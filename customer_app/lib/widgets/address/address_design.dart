import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/providers/address_provider.dart';
import 'package:user_app/models/address.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/screens/maps/map_screen.dart';
import 'package:user_app/services/translator_service.dart';
import 'package:user_app/providers/locale_provider.dart';

import 'package:shared_assets/extensions/extensions.dart'; 
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? value;
  final String? addressID;

  const AddressDesign({
    super.key,
    this.model,
    this.value,
    this.addressID,
  });

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  late Future<String> _translationFuture;

  @override
  void initState() {
    super.initState();
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _translationFuture = TranslationService.formatAndTranslateAddress(
      widget.model!.toJson(),
      localeProvider.locale.languageCode,
    );
  }

  void _selectAddress(AddressProvider addressProvider) {
    addressProvider.displayResult(
      widget.value!,
      address: widget.model?.toJson() ?? {},
      addressID: widget.addressID,
      lat: double.tryParse(widget.model?.lat ?? '0.0') ?? 0.0,
      lng: double.tryParse(widget.model?.lng ?? '0.0') ?? 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = context.watch<AddressProvider>();
    final isSelected = widget.value == addressProvider.count;
    final common = context.l10nCommon;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(color: Colors.redAccent, width: 2)
            : Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => _selectAddress(addressProvider),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFFFF1F1),
              child: Icon(Icons.location_on_rounded, color: Colors.redAccent, size: 22),
            ),
            title: Text(
              widget.model?.label ?? common.addrLabelFallback,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            subtitle: _buildSubtitle(context),
            trailing: Radio<int>(
              value: widget.value!,
              groupValue: addressProvider.count,
              activeColor: Colors.redAccent,
              onChanged: (value) => _selectAddress(addressProvider),
            ),
          ),
          if (isSelected) _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final t = context.l10nCommon;
    return FutureBuilder<String>(
      future: _translationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(t.addrTranslating, style: const TextStyle(fontSize: 12));
        }
        
        final translatedAddress = snapshot.data ?? t.addrErrorLoading;
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if ((widget.model?.houseNumber ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(t.addrBuilding(widget.model!.houseNumber!), 
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ),
                  if ((widget.model?.flatNumber ?? '').isNotEmpty)
                    Text(t.addrFlat(widget.model!.flatNumber!), 
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                translatedAddress,
                style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.3),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final t = context.l10nCommon;
    return Column(
      children: [
        const Divider(height: 1, indent: 16, endIndent: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(
                      initialLat: double.tryParse(widget.model?.lat ?? '0.0') ?? 0.0,
                      initialLng: double.tryParse(widget.model?.lng ?? '0.0') ?? 0.0,
                      isSightSeeing: true,
                    ),
                  ),
                ),
                icon: const Icon(Icons.map_outlined, size: 20),
                label: Text(t.addrSeeInMaps, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              _buildDeleteButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
      label: Text(
        context.l10nCommon.delete,
        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _showDeleteConfirmation(context),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    final common = context.l10nCommon;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(common.addrDeleteTitle),
        content: Text(common.addrDeleteBody(widget.model?.label ?? common.addrLabelFallback)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(common.cancel, style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUID)
                    .collection("addresses")
                    .doc(widget.addressID)
                    .delete();

                addressProvider.displayResult(-1, address: {});
                if (!mounted) return;
                unifiedSnackBar(common.addrDeleted);
              } catch (e) {
                if (!mounted) return;
                unifiedSnackBar(common.errorOccurred(e.toString()), error: true);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text(common.confirm, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}