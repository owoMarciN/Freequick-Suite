// lib/screens/active_delivery_screen.dart
//
// Rider app — active order screen with Google Map, polyline route,
// status stepper, action card, order details, and map FAB buttons.
//
// Status flow (AppConstants, synced with Cloud Functions):
//   statusInProgress → rider heads to restaurant
//   statusReady      → rider picked up food, heading to customer
//   statusDelivered  → order complete

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:shared_assets/utils/app_constants.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:shared_assets/extensions/extensions.dart';

const String _mapsApiKey = String.fromEnvironment('MAPS_API_KEY');

// ── Screen ────────────────────────────────────────────────────────────────────

class ActiveDeliveryScreen extends StatefulWidget {
  const ActiveDeliveryScreen({super.key});

  @override
  State<ActiveDeliveryScreen> createState() => _ActiveDeliveryScreenState();
}

class _ActiveDeliveryScreenState extends State<ActiveDeliveryScreen> {
  GoogleMapController? _mapController;
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RiderProvider>(
      builder: (context, provider, _) {
        final order = provider.activeOrder;
        final brand = Theme.of(context).extension<BrandColors>()!;

        if (order == null) {
          return Scaffold(
            backgroundColor: brand.cardSurface,
            body: Center(
              child: CircularProgressIndicator(color: brand.primary),
            ),
          );
        }

        final String status =
            order[AppConstants.fieldStatus]?.toString() ??
                AppConstants.statusInProgress;
        final String orderID = order['orderID']?.toString() ?? '';

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              _MapSection(
                order: order,
                status: status,
                onMapCreated: (c) => _mapController = c,
              ),

              DraggableScrollableSheet(
                controller: _sheetController,
                initialChildSize: 0.25,
                minChildSize: 0.14,
                maxChildSize: 0.5,
                snap: true,
                snapSizes: const [0.14, 0.25, 0.5],
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: brand.cardSurface,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20)),
                      boxShadow: const [
                        BoxShadow(blurRadius: 10, color: Colors.black12),
                      ],
                    ),
                    child: _BottomPanel(
                      order: order,
                      status: status,
                      orderID: orderID,
                      provider: provider,
                      scrollController: scrollController,
                    ),
                  );
                },
              ),

              _TopBar(orderID: orderID, status: status),
            ],
          ),
        );
      },
    );
  }
}

// ── Map section ───────────────────────────────────────────────────────────────

class _MapSection extends StatefulWidget {
  final Map<String, dynamic> order;
  final String status;
  final Function(GoogleMapController) onMapCreated;

  const _MapSection({
    required this.order,
    required this.status,
    required this.onMapCreated,
  });

  @override
  State<_MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<_MapSection> {
  GoogleMapController? _controller;
  Set<Polyline> _polylines = {};
  bool _loadingRoute = false;
  String? _lastStatus;
  LatLng? _currentRiderPosition;

  static const _fallback = LatLng(50.0647, 19.9450);

  LatLng _parseLatLng(dynamic data, String latKey, String lngKey,
      [LatLng fallback = _fallback]) {
    if (data is Map) {
      final lat = double.tryParse(data[latKey]?.toString() ?? '');
      final lng = double.tryParse(data[lngKey]?.toString() ?? '');
      if (lat != null && lng != null) return LatLng(lat, lng);
    }
    return fallback;
  }

  LatLng get _pickup {
    final order = widget.order;
    final lat =
        double.tryParse(order['restaurantLat']?.toString() ?? '') ??
            _fallback.latitude;
    final lng =
        double.tryParse(order['restaurantLng']?.toString() ?? '') ??
            _fallback.longitude;
    return LatLng(lat, lng);
  }

  LatLng get _dropoff =>
      _parseLatLng(widget.order['address'], 'lat', 'lng', _fallback);

  Future<void> _fetchRoute(LatLng origin, LatLng destination) async {
    _currentRiderPosition = origin;
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

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final routes = data['routes'] as List?;
      if (routes == null || routes.isEmpty) return;

      final decoded =
          _decodePolyline(routes[0]['overview_polyline']['points'] as String);

      if (!mounted) return;
      setState(() {
        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: decoded,
            color: const Color(0xFF4A6CF7),
            width: 5,
          ),
        };
      });
      _fitBounds(decoded);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingRoute = false);
    }
  }

  void _fitBounds(List<LatLng> points) {
    if (_controller == null || points.isEmpty) return;
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;
    for (final p in points) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    _controller!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        72.0,
      ),
    );
  }

  void _centerOnRider() {
    if (_controller == null) return;
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentRiderPosition ?? _pickup,
          zoom: 16,
        ),
      ),
    );
  }

  void _resetRouteView() {
    if (_polylines.isEmpty) return;
    _fitBounds(_polylines.first.points);
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

  void _updateRoute() {
    // In Progress = rider heading to restaurant (origin and destination are both pickup)
    // Ready = rider heading to customer
    final headingToRestaurant =
        widget.status == AppConstants.statusInProgress;
    _fetchRoute(_pickup, headingToRestaurant ? _pickup : _dropoff);
  }

  @override
  void didUpdateWidget(_MapSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != _lastStatus) {
      _lastStatus = widget.status;
      _updateRoute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickup = _pickup;
    final dropoff = _dropoff;
    final mid = LatLng(
      (pickup.latitude + dropoff.latitude) / 2,
      (pickup.longitude + dropoff.longitude) / 2,
    );

    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('pickup'),
        position: pickup,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: context.l10nRider.mapMarkerRestaurant,
          snippet: widget.order['restaurantName']?.toString() ??
              context.l10nRider.mapMarkerPickupSnippet,
        ),
      ),
      Marker(
        markerId: const MarkerId('dropoff'),
        position: dropoff,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: context.l10nRider.mapMarkerCustomer,
          snippet: context.l10nRider.mapMarkerDropoffSnippet,
        ),
      ),
    };

    // FAB sits just above the sheet at minChildSize (14%)
    final sheetOffset = MediaQuery.of(context).size.height * 0.14 + 16;

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (c) {
            _controller = c;
            _lastStatus = widget.status;
            widget.onMapCreated(c);
            _updateRoute();
          },
          initialCameraPosition: CameraPosition(target: mid, zoom: 13.5),
          markers: markers,
          polylines: _polylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          mapType: MapType.normal,
          style: _darkMapStyle,
        ),

        // Loading pill
        if (_loadingRoute)
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Text('Loading route…',
                        style:
                            TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

        // FAB buttons
        Positioned(
          right: 12,
          bottom: sheetOffset + 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MapFab(
                icon: Icons.my_location_rounded,
                tooltip: 'Center on my location',
                onTap: _centerOnRider,
              ),
              const SizedBox(height: 10),
              _MapFab(
                icon: Icons.fit_screen_rounded,
                tooltip: 'Show full route',
                onTap: _resetRouteView,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Map FAB ───────────────────────────────────────────────────────────────────

class _MapFab extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _MapFab({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: brand.cardSurface!.withValues(alpha: 0.92),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Icon(icon, color: brand.primary, size: 20),
        ),
      ),
    );
  }
}

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final String orderID;
  final String status;

  const _TopBar({required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final textBrand = Theme.of(context).textTheme.bodyLarge!;

    return Container(
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
          colors: [brand.muted!, Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          _GlassButton(
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            ),
            child: Icon(Icons.arrow_back_rounded,
                color: textBrand.color, size: 20),
          ),
          const SizedBox(width: 8),
          _GlassButton(
            child: Text(
              '#${orderID.length >= 8 ? orderID.substring(0, 8).toUpperCase() : orderID}',
              style: TextStyle(
                color: textBrand.color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const Spacer(),
          _GlassButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      color: brand.primary, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: TextStyle(
                    color: brand.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _GlassButton({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: brand.cardSurface!.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}

// ── Bottom panel ──────────────────────────────────────────────────────────────

class _BottomPanel extends StatelessWidget {
  final Map<String, dynamic> order;
  final String status;
  final String orderID;
  final RiderProvider provider;
  final ScrollController scrollController;

  const _BottomPanel({
    required this.order,
    required this.status,
    required this.orderID,
    required this.provider,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: brand.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _StatusStepper(status: status),
        Divider(color: brand.primaryDark, height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _ActionCard(
                  status: status, orderID: orderID, provider: provider),
              const SizedBox(height: 14),
              _OrderDetailsCard(order: order),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Status stepper ────────────────────────────────────────────────────────────

class _StatusStepper extends StatelessWidget {
  final String status;
  const _StatusStepper({required this.status});

  // Pipeline matches AppConstants order
  static const _pipeline = [
    AppConstants.statusInProgress,
    AppConstants.statusReady,
    AppConstants.statusDelivered,
  ];

  int _currentIndex() => _pipeline.indexOf(status).clamp(0, _pipeline.length - 1);

  @override
  Widget build(BuildContext context) {
    final cur = _currentIndex();
    final brand = Theme.of(context).extension<BrandColors>()!;

    final labels = [
      context.l10nRider.stepHeadingToStore,
      context.l10nRider.stepPickedUp,
      context.l10nRider.stepDelivered,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(_pipeline.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: i ~/ 2 < cur ? brand.primary : brand.primaryDark,
              ),
            );
          }
          final si = i ~/ 2;
          final done = si <= cur;
          final active = si == cur;

          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: done ? brand.primary : brand.primarySoft,
                  shape: BoxShape.circle,
                  border: active
                      ? Border.all(color: brand.primary!, width: 2)
                      : null,
                ),
                child: Center(
                  child: done && !active
                      ? const Icon(Icons.check_rounded,
                          size: 14, color: Colors.white)
                      : Text(
                          '${si + 1}',
                          style: TextStyle(
                            color: active
                                ? brand.primary
                                : brand.primaryDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                labels[si],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: done ? brand.primary : brand.primaryDark,
                  fontSize: 10,
                  fontWeight:
                      active ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Action card ───────────────────────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  final String status;
  final String orderID;
  final RiderProvider provider;

  const _ActionCard({
    required this.status,
    required this.orderID,
    required this.provider,
  });

  Map<String, dynamic> _config(BuildContext context) {
    if (status == AppConstants.statusInProgress) {
      return {
        'icon': Icons.directions_bike_rounded,
        'title': context.l10nRider.actionHeadToRestaurant,
        'subtitle': context.l10nRider.actionNavToPickup,
        'nextStatus': AppConstants.statusReady,
        'btnLabel': context.l10nRider.actionBtnPickedUp,
      };
    }
    if (status == AppConstants.statusReady) {
      return {
        'icon': Icons.delivery_dining_rounded,
        'title': context.l10nRider.actionDelivering,
        'subtitle': context.l10nRider.actionNavToCustomer,
        'nextStatus': AppConstants.statusDelivered,
        'btnLabel': context.l10nRider.actionBtnDelivered,
      };
    }
    if (status == AppConstants.statusDelivered) {
      return {
        'icon': Icons.check_circle_rounded,
        'title': context.l10nRider.actionOrderDeliveredTitle,
        'subtitle': context.l10nRider.actionOrderDeliveredSubtitle,
        'nextStatus': null,
        'btnLabel': '',
      };
    }
    return {
      'icon': Icons.schedule_rounded,
      'title': context.l10nRider.actionProcessing,
      'subtitle': context.l10nRider.actionPleaseWait,
      'nextStatus': null,
      'btnLabel': '',
    };
  }

  void _onTap(BuildContext context, String nextStatus) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    if (nextStatus == AppConstants.statusDelivered) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: scheme.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: Text(context.l10nRider.dialogConfirmDelivery,
              style: TextStyle(color: brand.primary)),
          content: Text(context.l10nRider.dialogHandedToCustomer,
              style: TextStyle(color: brand.primaryDark)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10nCommon.cancel,
                  style: TextStyle(color: brand.primaryDark)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                provider.updateOrderStatus(orderID, nextStatus);
              },
              child: Text(context.l10nRider.dialogYesDelivered),
            ),
          ],
        ),
      );
    } else {
      provider.updateOrderStatus(orderID, nextStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cfg = _config(context);
    final brand = Theme.of(context).extension<BrandColors>()!;
    final resolvedColor =
        status == AppConstants.statusDelivered ? brand.success! : brand.primary!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: resolvedColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: resolvedColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(cfg['icon'] as IconData, color: resolvedColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cfg['title'] as String,
                    style: TextStyle(
                        color: resolvedColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15)),
                Text(cfg['subtitle'] as String,
                    style:
                        TextStyle(color: brand.primaryDark, fontSize: 12)),
              ],
            ),
          ),
          if (cfg['nextStatus'] != null) ...[
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () => _onTap(context, cfg['nextStatus'] as String),
              style: ElevatedButton.styleFrom(
                backgroundColor: resolvedColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: provider.isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : Text(cfg['btnLabel'] as String,
                      style: const TextStyle(fontSize: 13)),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Order details card ────────────────────────────────────────────────────────

class _OrderDetailsCard extends StatefulWidget {
  final Map<String, dynamic> order;
  const _OrderDetailsCard({required this.order});

  @override
  State<_OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<_OrderDetailsCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final dividerColor = Theme.of(context).dividerColor;
    final order = widget.order;

    final String restaurantName = order['restaurantName']?.toString() ??
        context.l10nRider.defaultRestaurantName;
    final String total = '${order['totalAmount'] ?? '0.00'} zł';
    final String orderType = order['orderType']?.toString() ?? 'delivery';
    final String paymentMethod =
        order['paymentMethod']?.toString() ?? 'cash';
    final bool isCash = paymentMethod == 'cash' || paymentMethod == 'Cash';

    final addr = order['address'];
    String deliveryAddress = context.l10nRider.addressNotAvailable;
    if (addr is Map) {
      deliveryAddress = addr['fullAddress']?.toString() ??
          addr['address']?.toString() ??
          context.l10nRider.addressNotAvailable;
    }

    return Container(
      decoration: BoxDecoration(
        color: brand.cardBorder,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.receipt_long_outlined,
                      color: brand.primaryDark, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    context.l10nRider.orderDetailsTitle,
                    style: TextStyle(
                        color: brand.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (isCash ? brand.warning : brand.primary)!
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isCash
                              ? Icons.payments_outlined
                              : Icons.credit_card_rounded,
                          size: 13,
                          color: isCash ? brand.warning : brand.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isCash
                              ? context.l10nRider.paymentCash(total)
                              : context.l10nRider.paymentCard,
                          style: TextStyle(
                            color: isCash ? brand.warning : brand.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: brand.primaryDark,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            Divider(color: dividerColor, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.store_outlined,
                    iconColor: brand.primarySoft!,
                    label: restaurantName,
                    subtitle: orderType == 'pickup'
                        ? context.l10nRider.orderTypePickup
                        : context.l10nRider.orderTypeDelivery,
                  ),
                  const SizedBox(height: 10),
                  if (orderType != 'pickup')
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      iconColor: brand.primary!,
                      label: context.l10nRider.labelDeliveryAddress,
                      subtitle: deliveryAddress,
                    ),
                  if (orderType == 'pickup')
                    _InfoRow(
                      icon: Icons.storefront_rounded,
                      iconColor: brand.primary!,
                      label: context.l10nRider.labelPickup,
                      subtitle: context.l10nRider.subtitleCustomerCollects,
                    ),
                  Divider(color: dividerColor, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.l10nRider.orderTotal,
                          style: TextStyle(
                              color: brand.primaryDark, fontSize: 13)),
                      Text(total,
                          style: TextStyle(
                              color: brand.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: brand.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13)),
              Text(subtitle,
                  style:
                      TextStyle(color: brand.primaryDark, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Dark map style ────────────────────────────────────────────────────────────

const String _darkMapStyle = '''
[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},
{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},
{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},
{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},
{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},
{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]}]
''';