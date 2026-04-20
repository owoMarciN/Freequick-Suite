import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:merchant_app/services/location_service.dart';
import 'package:shared_assets/extensions/extensions.dart';

class MapDialog extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;

  const MapDialog({super.key, this.initialLat, this.initialLng});

  @override
  State<MapDialog> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapDialog> {
  final String _baseUrl = "https://europe-west1-freequick.cloudfunctions.net";

  late GoogleMapController _mapController;
  late LatLng _pickedLocation;
  String _currentAddress = '';
  bool _isLoading = false;
  List<dynamic> _suggestions = [];

  void _getSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
    try {
      final url =
          "$_baseUrl/googleMapsAutocomplete?input=${Uri.encodeComponent(input)}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _suggestions = json.decode(response.body)['predictions'] ?? [];
        });
      }
    } catch (e) {
      debugPrint("Autocomplete error: $e");
    }
  }

  void _handleSuggestionClick(String placeId) async {
    try {
      final url = "$_baseUrl/googleMapsDetails?placeId=$placeId";
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final lat = data['result']['geometry']['location']['lat'];
        final lng = data['result']['geometry']['location']['lng'];
        final newPos = LatLng(lat, lng);

        _mapController.animateCamera(CameraUpdate.newLatLngZoom(newPos, 16));

        setState(() {
          _suggestions = [];
          _pickedLocation = newPos;
          _currentAddress = data['result']['formatted_address'];
        });

        _getAddress(newPos);
      }
    } catch (e) {
      debugPrint("Details error: $e");
    }
  }

  void _getAddress(LatLng location) async {
    setState(() => _isLoading = true);
    try {
      final result = await LocationService.getUserLocationAddressFromGoogle(
        location.latitude,
        location.longitude,
      );
      setState(() {
        _currentAddress = result['fullAddress'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _currentAddress = context.l10nCommon.errorAddressNotFound;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pickedLocation = LatLng(
      widget.initialLat ?? 37.4220,
      widget.initialLng ?? -122.0841,
    );
    _getAddress(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Stack(
          children: [
            // -- Map --------------------------------------------------------
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _pickedLocation, zoom: 15),
              onMapCreated: (controller) => _mapController = controller,
              onCameraMove: (position) => _pickedLocation = position.target,
              onCameraIdle: () => _getAddress(_pickedLocation),
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),

            // -- Center pin -------------------------------------------------
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Icon(Icons.location_on, size: 45, color: brand.danger),
              ),
            ),

            // -- Search bar -------------------------------------------------
            Positioned(
              top: 70,
              left: 15,
              right: 15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outline),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 14, color: scheme.onSurface),
                      decoration: InputDecoration(
                        hintText: context.l10nCommon.searchAddress,
                        hintStyle:
                            TextStyle(fontSize: 14, color: brand.muted),
                        prefixIcon:
                            Icon(Icons.search_rounded, color: brand.muted),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(15),
                      ),
                      onChanged: _getSuggestions,
                    ),
                  ),
                  if (_suggestions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: scheme.outline),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        constraints: const BoxConstraints(maxHeight: 250),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _suggestions.length,
                            separatorBuilder: (_, __) =>
                                Divider(height: 1, color: scheme.outline),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(Icons.location_on_rounded,
                                    color: brand.muted, size: 20),
                                title: Text(
                                  _suggestions[index]['description'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: scheme.onSurface),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _handleSuggestionClick(
                                      _suggestions[index]['place_id']);
                                  setState(() => _suggestions = []);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // -- Bottom panel -----------------------------------------------
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outline),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.map_rounded, color: brand.muted, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _isLoading
                                ? context.l10nCommon.map_fetching_address
                                : _currentAddress,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: scheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (_isLoading)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: brand.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle_outline_rounded,
                          size: 22),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brand.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            brand.primary!.withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.pop(context, {
                                "address": _currentAddress,
                                "latitude": _pickedLocation.latitude,
                                "longitude": _pickedLocation.longitude,
                              }),
                      label: Text(
                        context.l10nCommon.confirm,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}