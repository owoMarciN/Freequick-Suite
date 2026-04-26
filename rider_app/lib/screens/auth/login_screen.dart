import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/screens/auth/otp_screen.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/widgets/text_fields/custom_password_field.dart';
import 'package:shared_assets/widgets/text_fields/custom_phone_field.dart';
import 'package:shared_assets/widgets/text_fields/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late final PhoneController _phoneCtrl;

  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _phoneCtrl = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.PL, nsn: ''),
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Sign in with email
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      if (!mounted) return;

      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            args: OtpScreenArgs(
              email: _emailCtrl.text.trim(),
              password: _passwordCtrl.text,
              phone: _phoneCtrl.value.international,
            ),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = switch (e.code) {
          'user-not-found' => context.l10nRider.loginErrorUserNotFound,
          'wrong-password' => context.l10nRider.loginErrorWrongPassword,
          'invalid-email' => context.l10nRider.loginErrorInvalidEmail,
          'user-disabled' => context.l10nRider.loginErrorUserDisabled,
          _ => e.message ?? context.l10nRider.loginErrorDefault,
        };
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = context.l10nRider.loginErrorGeneric);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    context.l10nRider.welcomeBackTitle,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 36,
                      height: 1.15,
                      color: brand.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10nRider.signInToContinueSubtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: brand.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    data: Icons.email_outlined,
                    controller: _emailCtrl,
                    hintText: context.l10nRider.emailAddressHint,
                    isObsecure: false,
                    customValidator: (v) => (v == null || v.trim().isEmpty)
                        ? context.l10nRider.emailRequiredError
                        : null,
                  ),
                  const SizedBox(height: 12),
                  CustomPasswordField(
                    controller: _passwordCtrl,
                    label: context.l10nRider.passwordLabel,
                    isRequired: true,
                    isConfirmation: true,
                  ),
                  const SizedBox(height: 12),
                  CustomPhoneField(
                    controller: _phoneCtrl,
                    label: context.l10nRider.phoneForOtpLabel,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: brand.danger!.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: brand.danger!.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: brand.danger,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: TextStyle(
                                color: brand.danger,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  Center(
                    child: SizedBox(
                      width: 240,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shadowColor: Colors.black.withValues(alpha: 0.8),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                context.l10nCommon.word_continue,
                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
