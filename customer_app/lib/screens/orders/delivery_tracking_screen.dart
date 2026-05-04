// lib/screens/orders/delivery_tracking_screen.dart
//
// Customer-facing live delivery tracking screen.
//
// Data source: orders/{orderID} — subscribed via Firestore real-time listener.
// The cloud function onRiderLocationUpdate writes:
//   eta.minMinutes, eta.maxMinutes, eta.updatedAt, eta.source
// The cloud function onOrderStatusChanged mirrors status changes here.
//
// Rider live location comes from riders/{riderUID} — subscribed separately
// once riderUID is known from the order document.
//
// Usage:
//   Navigator.push(context, MaterialPageRoute(
//     builder: (_) => DeliveryTrackingScreen(
//       orderID: orderID,
//       restaurantName: restaurantName,
//     ),
//   ));

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/global/global.dart';

const String _mapsApiKey = String.fromEnvironment('MAPS_API_KEY');

// ── Screen ────────────────────────────────────────────────────────────────────

class DeliveryTrackingScreen extends StatefulWidget {
  final String orderID;
  final String restaurantName;

  const DeliveryTrackingScreen({
    super.key,
    required this.orderID,
    required this.restaurantName,
  });

  @override
  State<DeliveryTrackingScreen> createState() =>
      _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen>
    with SingleTickerProviderStateMixin {
  // Map
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  // Subscriptions
  StreamSubscription<DocumentSnapshot>? _orderSub;
  StreamSubscription<DocumentSnapshot>? _riderSub;

  // State
  Map<String, dynamic>? _orderData;
  LatLng? _riderLatLng;
  bool _riderStale = false;
  DateTime? _lastRiderUpdate;
  Timer? _staleTimer;
  bool _loadingRoute = false;
  String? _lastRouteCacheKey;

  // Animation
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  static const _fallback = LatLng(50.0647, 19.9450);

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnim = CurvedAnimation(
      parent: _pulseCtrl,
      curve: Curves.easeInOut,
    );

    _subscribeToOrder();
  }

  @override
  void dispose() {
    _orderSub?.cancel();
    _riderSub?.cancel();
    _staleTimer?.cancel();
    _pulseCtrl.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  // ── Firestore subscriptions ───────────────────────────────────────────────

  void _subscribeToOrder() {
    _orderSub = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUID)
        .collection('orders')
        .doc(widget.orderID)
        .snapshots()
        .listen((snap) {
      if (!snap.exists || !mounted) return;
      final data = snap.data()!;
      final newRiderUID = data['riderUID'] as String?;
      final oldRiderUID = _orderData?['riderUID'] as String?;

      setState(() => _orderData = data);
      _rebuildMarkers();

      // Subscribe to rider location once riderUID is available
      if (newRiderUID != null &&
          newRiderUID.isNotEmpty &&
          newRiderUID != oldRiderUID) {
        _subscribeToRider(newRiderUID);
      }
    });
  }

  void _subscribeToRider(String riderUID) {
    _riderSub?.cancel();
    _riderSub = FirebaseFirestore.instance
        .collection('riders')
        .doc(riderUID)
        .snapshots()
        .listen((snap) {
      if (!snap.exists || !mounted) return;
      final data = snap.data()!;
      final loc = data['location'];
      if (loc is Map) {
        final lat = (loc['lat'] as num?)?.toDouble();
        final lng = (loc['lng'] as num?)?.toDouble();
        if (lat != null && lng != null) {
          final newLatLng = LatLng(lat, lng);
          final prevLatLng = _riderLatLng;
          setState(() {
            _riderLatLng = newLatLng;
            _lastRiderUpdate = DateTime.now();
            _riderStale = false;
          });
          _resetStaleTimer();
          _rebuildMarkers();

          // Re-fetch route only if rider moved meaningfully (>30m)
          if (prevLatLng == null ||
              _haversineKm(prevLatLng, newLatLng) > 0.03) {
            _fetchRouteForCurrentPhase();
          }

          // Animate camera to keep rider in view
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(newLatLng),
          );
        }
      }
    });
  }

  // ── Markers ───────────────────────────────────────────────────────────────

  void _rebuildMarkers() {
    if (_orderData == null) return;
    final data = _orderData!;

    final markers = <Marker>{};

    // Restaurant marker
    final restLat = (data['restaurantLat'] as num?)?.toDouble();
    final restLng = (data['restaurantLng'] as num?)?.toDouble();
    if (restLat != null && restLng != null) {
      markers.add(Marker(
        markerId: const MarkerId('restaurant'),
        position: LatLng(restLat, restLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: widget.restaurantName),
      ));
    }

    // Customer / dropoff marker
    final addr = data['address'];
    if (addr is Map) {
      final lat = double.tryParse(addr['lat']?.toString() ?? '');
      final lng = double.tryParse(addr['lng']?.toString() ?? '');
      if (lat != null && lng != null) {
        markers.add(Marker(
          markerId: const MarkerId('dropoff'),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Your location'),
        ));
      }
    }

    // Rider marker
    if (_riderLatLng != null) {
      markers.add(Marker(
        markerId: const MarkerId('rider'),
        position: _riderLatLng!,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(title: 'Your rider'),
      ));
    }

    if (mounted) setState(() => _markers = markers);
  }

  // ── Route ─────────────────────────────────────────────────────────────────

  void _fetchRouteForCurrentPhase() {
    if (_orderData == null || _riderLatLng == null) return;
    final data = _orderData!;
    final status = data['status']?.toString() ?? '';

    LatLng? destination;

    // In Progress = heading to restaurant (pickup leg)
    if (status == 'In Progress') {
      final lat = (data['restaurantLat'] as num?)?.toDouble();
      final lng = (data['restaurantLng'] as num?)?.toDouble();
      if (lat != null && lng != null) {
        destination = LatLng(lat, lng);
      }
    }
    // Ready = heading to customer (dropoff leg)
    else if (status == 'Ready') {
      final addr = data['address'];
      if (addr is Map) {
        final lat = double.tryParse(addr['lat']?.toString() ?? '');
        final lng = double.tryParse(addr['lng']?.toString() ?? '');
        if (lat != null && lng != null) {
          destination = LatLng(lat, lng);
        }
      }
    }

    if (destination == null) return;

    // Cache key prevents refetching the same route repeatedly
    final cacheKey =
        '${_riderLatLng!.latitude.toStringAsFixed(3)}_${_riderLatLng!.longitude.toStringAsFixed(3)}_${destination.latitude}_${destination.longitude}';
    if (cacheKey == _lastRouteCacheKey) return;
    _lastRouteCacheKey = cacheKey;

    _fetchRoute(_riderLatLng!, destination);
  }

  Future<void> _fetchRoute(LatLng origin, LatLng destination) async {
    if (_mapsApiKey.isEmpty) return;
    if (mounted) setState(() => _loadingRoute = true);

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=driving'
        '&key=$_mapsApiKey',
      );
      final res = await http.get(url);
      if (res.statusCode != 200) return;

      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final routes = json['routes'] as List?;
      if (routes == null || routes.isEmpty) return;

      final decoded =
          _decodePolyline(routes[0]['overview_polyline']['points'] as String);

      if (!mounted) return;
      setState(() {
        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: decoded,
            color: const Color(0xFFFF4757),
            width: 4,
          ),
        };
      });
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingRoute = false);
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    final List<LatLng> points = [];
    int index = 0, lat = 0, lng = 0;
    while (index < encoded.length) {
      int shift = 0, result = 0, b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  // ── Utilities ─────────────────────────────────────────────────────────────

  double _haversineKm(LatLng a, LatLng b) {
    const r = 6371.0;
    final dLat = (b.latitude - a.latitude) * math.pi / 180;
    final dLng = (b.longitude - a.longitude) * math.pi / 180;
    final h = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(a.latitude * math.pi / 180) *
            math.cos(b.latitude * math.pi / 180) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    return 2 * r * math.asin(math.sqrt(h));
  }

  String _formatDistance(LatLng? from, LatLng? to) {
    if (from == null || to == null) return '--';
    final km = _haversineKm(from, to);
    return km < 1
        ? '${(km * 1000).round()} m'
        : '${km.toStringAsFixed(1)} km';
  }

  void _resetStaleTimer() {
    _staleTimer?.cancel();
    _staleTimer = Timer(const Duration(minutes: 1), () {
      if (mounted) setState(() => _riderStale = true);
    });
  }

  String _etaText() {
    final data = _orderData;
    if (data == null) return '--';
    final eta = data['eta'];
    if (eta is Map) {
      final min = eta['minMinutes'];
      final max = eta['maxMinutes'];
      if (min != null && max != null) {
        return '$min–$max min';
      }
    }
    return '--';
  }

  String _statusLabel(String status) {
    return switch (status) {
      'Pending' => 'Order received',
      'In Progress' => 'Rider heading to restaurant',
      'Ready' => 'Rider on the way to you',
      'Delivered' => 'Delivered!',
      _ => status,
    };
  }

  Color _statusColor(String status) {
    return switch (status) {
      'Pending' => const Color(0xFFD97706),
      'In Progress' => const Color(0xFFFF4757),
      'Ready' => const Color(0xFF2196F3),
      'Delivered' => const Color(0xFF00C48C),
      _ => Colors.grey,
    };
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final data = _orderData;
    final status = data?['status']?.toString() ?? 'Pending';
    final isDelivered = status == 'Delivered';

    // Initial camera position
    LatLng initialTarget = _fallback;
    if (data != null) {
      final lat = (data['restaurantLat'] as num?)?.toDouble();
      final lng = (data['restaurantLng'] as num?)?.toDouble();
      if (lat != null && lng != null) initialTarget = LatLng(lat, lng);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      body: Stack(
        children: [
          // ── Map ───────────────────────────────────────────────────────────
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child: data == null
                ? const Center(
                    child: CircularProgressIndicator(
                        color: Color(0xFFFF4757)))
                : GoogleMap(
                    onMapCreated: (c) {
                      _mapController = c;
                      _fetchRouteForCurrentPhase();
                    },
                    initialCameraPosition: CameraPosition(
                      target: initialTarget,
                      zoom: 14,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    style: _darkMapStyle,
                  ),
          ),

          // Route loading pill
          if (_loadingRoute)
            Positioned(
              top: MediaQuery.of(context).padding.top + 56,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Text('Calculating route…',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),

          // ── Top bar ───────────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 12,
                right: 12,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  _GlassChip(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 10),
                  _GlassChip(
                    child: Text(
                      '#${widget.orderID.length >= 8 ? widget.orderID.substring(0, 8).toUpperCase() : widget.orderID}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (_riderStale)
                    _GlassChip(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.signal_wifi_off,
                              color: Colors.orange, size: 14),
                          SizedBox(width: 5),
                          Text('Reconnecting…',
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 12)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Bottom info panel ─────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0F1923),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: data == null
                  ? const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFFFF4757))),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                          20,
                          20,
                          20,
                          MediaQuery.of(context).padding.bottom + 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Drag handle
                          Container(
                            width: 36,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                          // Status row
                          Row(
                            children: [
                              AnimatedBuilder(
                                animation: _pulseAnim,
                                builder: (_, __) => Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: _statusColor(status).withValues(
                                        alpha: 0.4 +
                                            _pulseAnim.value * 0.6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _statusLabel(status),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _statusColor(status)
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: _statusColor(status)
                                          .withValues(alpha: 0.4)),
                                ),
                                child: Text(
                                  _statusLabel(status),
                                  style: TextStyle(
                                    color: _statusColor(status),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ETA + distance cards
                          if (!isDelivered)
                            Row(
                              children: [
                                Expanded(
                                  child: _InfoCard(
                                    icon: Icons.access_time_rounded,
                                    label: 'ETA',
                                    value: _etaText(),
                                    color: const Color(0xFFFF4757),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _InfoCard(
                                    icon: Icons.straighten_rounded,
                                    label: 'Distance',
                                    value: _formatDistance(
                                      _riderLatLng,
                                      () {
                                        if (status == 'In Progress') {
                                          final lat = (data[
                                                  'restaurantLat']
                                              as num?)
                                              ?.toDouble();
                                          final lng = (data[
                                                  'restaurantLng']
                                              as num?)
                                              ?.toDouble();
                                          if (lat != null && lng != null) {
                                            return LatLng(lat, lng);
                                          }
                                        } else {
                                          final addr = data['address'];
                                          if (addr is Map) {
                                            final lat =
                                                double.tryParse(
                                                    addr['lat']
                                                            ?.toString() ??
                                                        '');
                                            final lng =
                                                double.tryParse(
                                                    addr['lng']
                                                            ?.toString() ??
                                                        '');
                                            if (lat != null &&
                                                lng != null) {
                                              return LatLng(lat, lng);
                                            }
                                          }
                                        }
                                        return null;
                                      }(),
                                    ),
                                    color: const Color(0xFF2196F3),
                                  ),
                                ),
                              ],
                            ),

                          if (isDelivered) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00C48C)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: const Color(0xFF00C48C)
                                        .withValues(alpha: 0.3)),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      color: Color(0xFF00C48C),
                                      size: 22),
                                  SizedBox(width: 10),
                                  Text(
                                    'Your order has been delivered!',
                                    style: TextStyle(
                                      color: Color(0xFF00C48C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF00C48C),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text('Back to order',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],

                          const SizedBox(height: 16),

                          // Rider status row
                          Row(
                            children: [
                              const Icon(Icons.delivery_dining_rounded,
                                  color: Colors.white54, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                _riderLatLng != null
                                    ? 'Rider location live'
                                    : 'Waiting for rider location…',
                                style: TextStyle(
                                  color: _riderLatLng != null
                                      ? Colors.white54
                                      : Colors.orange.shade300,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              if (_lastRiderUpdate != null)
                                Text(
                                  'Updated just now',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withValues(alpha: 0.3),
                                    fontSize: 11,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Supporting widgets ────────────────────────────────────────────────────────

class _GlassChip extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _GlassChip({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: child,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                    color: color.withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dark map style ─────────────────────────────────────────────────────────────

const String _darkMapStyle = '''
[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},
{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},
{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},
{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},
{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},
{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},
{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},
{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2c6675"}]},
{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},
{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#4e6d70"}]}]
''';