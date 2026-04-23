import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';

import 'package:user_app/global/global.dart';
import 'package:user_app/models/address.dart';
import 'package:user_app/services/location_service.dart';
import 'package:user_app/screens/maps/map_screen.dart';

import 'package:user_app/widgets/ui/unified_app_bar.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

class SaveAddressScreen extends StatefulWidget {
  const SaveAddressScreen({super.key});

  @override
  State<SaveAddressScreen> createState() => _SaveAddressScreenState();
}

class _SaveAddressScreenState extends State<SaveAddressScreen> {
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _houseNumber = TextEditingController();
  final TextEditingController _flatNumber = TextEditingController();
  final TextEditingController _postCode = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _completeAddress = TextEditingController();

  String _selectedLabel = "Home"; // default (will be overridden by UI selection)
  bool isLoading = false;
  bool _isAddressFetched = false;
  double lat = 0.0;
  double lng = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleMapResult();
    });
  }

  void _assignAddressData(Map<String, dynamic> result) {
    final l10n = context.l10nCommon;

    setState(() {
      _city.text = result['city'] ?? '';
      _state.text = result['state'] ?? '';
      _postCode.text = result['postalCode'] ?? '';
      _street.text = result['road'] ?? '';
      _houseNumber.text = result['houseNumber'] ?? '';

      String sub = result['subpremise'] ?? '';
      _flatNumber.text = sub.isNotEmpty ? "${l10n.aptPrefix} $sub" : "";
      _completeAddress.text = result['fullAddress'] ?? '';

      lat = result['lat'] ?? 0.0;
      lng = result['lng'] ?? 0.0;
      _isAddressFetched = true;
    });
  }

  void _handleMapResult() async {
    Map<String, double>? coords =
        await LocationService.getUserCurrentCoordinates();
    if (!mounted) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapScreen(
          initialLat: coords?['lat'],
          initialLng: coords?['lng'],
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      _assignAddressData(result);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
    IconData? icon,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, size: 20) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) =>
          (required && (value == null || value.isEmpty))
              ? context.l10nCommon.required
              : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nCommon;

    return Scaffold(
      appBar: UnifiedAppBar(
        title: l10n.deliveryAddress,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: _isAddressFetched ? _buildSaveButton() : null,
      body: _isAddressFetched
          ? _buildForm()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildForm() {
    final l10n = context.l10nCommon;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              color: Colors.cyan.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.cyan),
                title: Text(
                  _completeAddress.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
                trailing: TextButton(
                  onPressed: _handleMapResult,
                  child: Text(l10n.change),
                ),
              ),
            ),

            _buildSectionTitle(l10n.addressLabel),

            Row(
              children: [
                l10n.home,
                l10n.work,
                l10n.other,
              ].map((label) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(label),
                    selected: _selectedLabel == label,
                    onSelected: (_) => setState(() => _selectedLabel = label),
                    selectedColor: Colors.cyan.withValues(alpha: 0.3),
                  ),
                );
              }).toList(),
            ),

            const Divider(height: 32),
            _buildSectionTitle(l10n.locationDetails),

            Row(
              children: [
                Expanded(
                  child: _buildField(
                    label: l10n.house,
                    controller: _houseNumber,
                    icon: Icons.home,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    label: l10n.flat,
                    controller: _flatNumber,
                    required: false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildField(
              label: l10n.street,
              controller: _street,
              icon: Icons.add_road,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildField(
                    label: l10n.city,
                    controller: _city,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    label: l10n.postcode,
                    controller: _postCode,
                    type: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildField(
              label: l10n.state,
              controller: _state,
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    final l10n = context.l10nCommon;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: isLoading ? null : _validateAndSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                l10n.saveAddress,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Future<void> _validateAndSave() async {
    final l10n = context.l10nCommon;

    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final docRef = FirebaseFirestore.instance
          .collection("users")
          .doc(currentUID)
          .collection("addresses")
          .doc();

      final model = Address(
        label: _selectedLabel,
        country: _completeAddress.text.split(',').last.trim(),
        state: _state.text.trim(),
        city: _city.text.trim(),
        road: _street.text.trim(),
        postalCode: _postCode.text.trim(),
        houseNumber: _houseNumber.text.trim(),
        flatNumber: _flatNumber.text.trim(),
        fullAddress: _completeAddress.text.trim(),
        lat: lat.toString(),
        lng: lng.toString(),
        addressID: docRef.id,
      ).toJson();

      await docRef.set(model);

      if (mounted) {
        unifiedSnackBar(l10n.addressSavedSuccess);
        Navigator.pop(context);
      }
    } catch (e) {
      unifiedSnackBar(
        l10n.addressSaveError(e.toString()),
        error: true,
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}