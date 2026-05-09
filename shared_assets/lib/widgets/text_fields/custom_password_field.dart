import 'package:flutter/material.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:shared_assets/widgets/dialogs/custom_error_message.dart';
import 'package:shared_assets/extensions/extensions.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final bool isRequired;
  final bool isConfirmation;

  const CustomPasswordField({
    super.key,
    this.controller,
    this.label,
    this.isRequired = true,
    this.isConfirmation = false,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  late FocusNode _focusNode;
  String? _errorMessage;

  final Set<ValidationRule> _passwordRules = {
    DigitValidationRule(),
    UppercaseValidationRule(),
    LowercaseValidationRule(),
    SpecialCharacterValidationRule(),
    MinCharactersValidationRule(6),
    MaxCharactersValidationRule(12),
  };

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  void _setUIError(String? message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _errorMessage != message) {
        setState(() => _errorMessage = message);
      }
    });
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
          FancyPasswordField(
            validationRules: widget.isConfirmation ? {} : _passwordRules,
            strengthIndicatorBuilder: widget.isConfirmation
                ? (strength) => const SizedBox.shrink()
                : (strength) => _buildStrengthUI(strength, brand, scheme),
            validationRuleBuilder: widget.isConfirmation
                ? (rules, value) => const SizedBox.shrink()
                : (rules, value) => _buildRulesUI(rules, value, brand, scheme),
            focusNode: _focusNode,
            controller: widget.controller,
            style: TextStyle(fontSize: 15, color: scheme.onSurface),
            decoration: InputDecoration(
              hintText: widget.label,
              hintStyle: TextStyle(color: brand.muted, fontSize: 14),
              prefixIcon: Icon(
                widget.isConfirmation ? Icons.lock_reset : Icons.lock_outline,
                size: 24,
                color: _focusNode.hasFocus ? brand.primary : brand.muted,
              ),
              suffixIconColor: brand.muted,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: brand.primaryDark,
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
            validator: (password) {
              if (widget.isRequired && (password == null || password.isEmpty)) {
                _setUIError(context.l10nCommon.field_error_required);
                return "req";
              }
              if (!widget.isConfirmation) {
                final allRulesMet = _passwordRules
                    .every((rule) => rule.validate(password ?? ''));
                if (!allRulesMet) {
                  _setUIError(context.l10nCommon.field_error_password_req);
                  return "inv";
                }
              }
              _setUIError(null);
              return null;
            },
          ),
          CustomErrorMessage(errorMessage: _errorMessage),
        ],
      ),
    );
  }

  Widget _buildStrengthUI(
      double strength, BrandColors brand, ColorScheme scheme) {
    if (strength == 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: strength,
          backgroundColor: scheme.outlineVariant,
          valueColor: AlwaysStoppedAnimation<Color>(
            strength < 0.4
                ? brand.danger!
                : strength < 0.7
                    ? brand.warning!
                    : brand.success!,
          ),
          minHeight: 4,
        ),
      ),
    );
  }

  Widget _buildRulesUI(Set<ValidationRule> rules, String value,
      BrandColors brand, ColorScheme scheme) {
    if (value.isEmpty || !_focusNode.hasFocus) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceBright,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...rules.map((rule) {
            final isValid = rule.validate(value);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(
                    isValid ? Icons.check_circle : Icons.circle_outlined,
                    size: 14,
                    color: isValid ? brand.success : brand.muted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    rule.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: isValid ? brand.success : brand.muted,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
