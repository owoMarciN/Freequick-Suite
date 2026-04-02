import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/screens/auth/otp_screen.dart';
import 'package:rider_app/utils/app_theme.dart';
import 'package:rider_app/widgets/custom_text_field.dart';
import 'package:rider_app/widgets/custom_password_field.dart';
import 'package:rider_app/widgets/custom_phone_field.dart';
import 'package:phone_form_field/phone_form_field.dart';

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
      setState(() {
        _error = switch (e.code) {
          'user-not-found' => 'No account found for this email.',
          'wrong-password' => 'Incorrect password.',
          'invalid-email' => 'Please enter a valid email address.',
          'user-disabled' => 'This account has been disabled.',
          _ => e.message ?? 'Login failed. Try again.',
        };
      });
    } catch (_) {
      setState(() => _error = 'Something went wrong. Try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
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
                    'Welcome\nBack',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 36,
                        height: 1.15,
                        color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue delivering',
                    style:
                        TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    data: Icons.email_outlined,
                    controller: _emailCtrl,
                    hintText: 'Email address',
                    isObsecure: false,
                    customValidator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Email is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  CustomPasswordField(
                    controller: _passwordCtrl,
                    label: 'Password',
                    isRequired: true,
                    isConfirmation: true,
                  ),
                  const SizedBox(height: 12),
                  CustomPhoneField(
                    controller: _phoneCtrl,
                    label: 'Phone number for OTP verification',
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.danger.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppTheme.danger.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline_rounded,
                              color: AppTheme.danger, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: const TextStyle(
                                  color: AppTheme.danger, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text(
                              'Continue',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
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