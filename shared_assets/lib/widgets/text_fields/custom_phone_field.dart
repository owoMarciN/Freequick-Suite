import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:shared_assets/widgets/dialogs/custom_error_message.dart';
import 'package:shared_assets/extensions/extensions.dart';

class CustomPhoneField extends StatefulWidget {
  final PhoneController? controller;
  final String? label;

  const CustomPhoneField({
    super.key,
    this.controller,
    this.label,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  late FocusNode _focusNode;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: brand.muted,
                size: 20,
              ),
              textTheme: Theme.of(context).textTheme.copyWith(
                    bodyMedium: TextStyle(
                      color: scheme.onSurface,
                      fontSize: 15,
                    ),
                  ),
            ),
            child: PhoneFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              style: TextStyle(fontSize: 15, color: scheme.onSurface),
              cursorColor: brand.primary,
              countrySelectorNavigator: const CountrySelectorNavigator.dialog(
                width: 400,
                showDialCode: true,
              ),
              decoration: InputDecoration(
                prefixIconColor: brand.muted,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                filled: true,
                fillColor: scheme.surface,
                hintText: widget.label,
                hintStyle: TextStyle(color: brand.muted, fontSize: 14),
                errorStyle: const TextStyle(fontSize: 0, height: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: scheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: brand.primary!, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: brand.danger!, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: brand.danger!, width: 1.5),
                ),
              ),
              validator: (phoneNumber) {
                final validators = PhoneValidator.compose([
                  PhoneValidator.required(context),
                  PhoneValidator.validMobile(context),
                ]);
                final error = validators(phoneNumber);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _errorMessage != error) {
                    setState(() => _errorMessage = error);
                  }
                });
                return error;
              },
            ),
          ),
          CustomErrorMessage(errorMessage: _errorMessage),
        ],
      ),
    );
  }
}
