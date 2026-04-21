import 'dart:async';
import 'package:flutter/material.dart';
import "package:user_app/services/location_service.dart";
import 'package:provider/provider.dart';
import 'package:user_app/providers/locale_provider.dart';

import 'package:shared_assets/extensions/extensions.dart';

import 'package:user_app/screens/address/address_screen.dart';
import 'package:user_app/providers/address_provider.dart';
import "package:user_app/services/translator_service.dart";

class AddressHeader extends StatefulWidget {
  const AddressHeader({super.key});

  @override
  State<AddressHeader> createState() => _AddressHeaderState();
}

class _AddressHeaderState extends State<AddressHeader> {
  String _location = "";
  bool _showFullAddress = false;
  Timer? _refreshTimer;

  Locale? _lastLocale;
  int? _lastAddressIndex;

  @override
  void initState() {
    super.initState();
    // Only periodic refresh if no manual address is selected (using live GPS)
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      if (mounted && addressProvider.count < 0) {
        _updateAddress();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localeProvider = Provider.of<LocaleProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);

    // Only re-fetch if the language changed or the user selected a different saved address
    if (_lastLocale != localeProvider.locale ||
        _lastAddressIndex != addressProvider.count) {
      _lastLocale = localeProvider.locale;
      _lastAddressIndex = addressProvider.count;
      _updateAddress();
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _updateAddress() async {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final languageCode = localeProvider.locale.languageCode;

    // 1. Logic for Manual Selection
    if (addressProvider.count >= 0) {
      final dataToProcess = addressProvider.address;

      String finalAddress = await TranslationService.formatAndTranslateAddress(
          dataToProcess, languageCode);

      if (mounted) {
        setState(() => _location = finalAddress);
      }
    }
    // 2. Logic for Live Current Location
    else {
      if (mounted && _location.isEmpty) {
        setState(() => _location = context.l10nCommon.addrTranslating);
      }

      try {
        final data = await LocationService.fetchUserCurrentLocation(
            langCode: languageCode);

        if (mounted) {
          setState(() => _location = data['fullAddress'] ?? "");
        }
      } catch (e) {
        if (mounted) {
          setState(() => _location = context.l10nCommon.errorAddressNotFound);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Navigates to address selection screen
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddressScreen())),
            child: const Icon(Icons.location_on, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _showFullAddress = !_showFullAddress),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _location.isEmpty
                        ? context.l10nCommon.addrTranslating
                        : _location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                    maxLines: _showFullAddress ? 3 : 1,
                    overflow: _showFullAddress
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              _showFullAddress
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () =>
                setState(() => _showFullAddress = !_showFullAddress),
          ),
        ],
      ),
    );
  }
}
