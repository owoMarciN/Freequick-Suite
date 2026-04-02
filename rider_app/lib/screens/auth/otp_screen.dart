import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider_app/screens/auth/profile_setup_screen.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:rider_app/utils/app_theme.dart';

class OtpScreenArgs {
  final String email;
  final String password;
  final String phone;

  const OtpScreenArgs({
    required this.email,
    required this.password,
    required this.phone,
  });
}

class OtpScreen extends StatefulWidget {
  final OtpScreenArgs args;

  const OtpScreen({super.key, required this.args});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String? _verificationId;
  int? _resendToken;

  bool _isSending = true;
  bool _isVerifying = false;
  String? _error;

  static const int _resendCooldown = 60;
  int _secondsLeft = _resendCooldown;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  Future<void> _sendOtp({bool forceResend = false}) async {
    setState(() {
      _isSending = true;
      _error = null;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: widget.args.phone,
      forceResendingToken: forceResend ? _resendToken : null,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await _verifyWithCredential(credential);
      },
      verificationFailed: (e) {
        if (!mounted) return;
        setState(() {
          _isSending = false;
          _error = e.message ?? 'Failed to send OTP.';
        });
      },
      codeSent: (verificationId, resendToken) {
        if (!mounted) return;
        setState(() {
          _verificationId = verificationId;
          _resendToken = resendToken;
          _isSending = false;
        });
        _startCountdown();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() => _secondsLeft = _resendCooldown);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _verify() async {
    final code = _controllers.map((c) => c.text).join();
    if (code.length < 6 || _verificationId == null) return;

    setState(() {
      _isVerifying = true;
      _error = null;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );
      await _verifyWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      for (final c in _controllers) { c.clear(); }
      _focusNodes.first.requestFocus();
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
        _error = switch (e.code) {
          'invalid-verification-code' =>
            'Incorrect code. Check the SMS and try again.',
          'session-expired' => 'The code expired. Tap Resend to get a new one.',
          _ => e.message ?? 'Verification failed. Try again.',
        };
      });
    }
  }

  Future<void> _verifyWithCredential(AuthCredential credential) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Email user not signed in');

    try {
      await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'provider-already-linked') {
        // Phone already linked, ignore
      } else if (e.code == 'credential-already-in-use') {
        // Phone used by another user, sign in with phone
        await _auth.signInWithCredential(credential);
      } else {
        rethrow;
      }
    }

    if (!mounted) return;

    final uid = _auth.currentUser!.uid;
    final riderDoc = await _db.collection('riders').doc(uid).get();

    if (!mounted) return;

    if (riderDoc.exists) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: AppTheme.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                color: AppTheme.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _isSending
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.primary))
            : SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify\nYour Number',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontSize: 32,
                                height: 1.15,
                                color: AppTheme.textPrimary),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter the 6-digit code sent to\n${widget.args.phone}',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                            height: 1.5),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) => _buildBox(i)),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 16),
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
                          onPressed: _isVerifying ? null : _verify,
                          child: _isVerifying
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : const Text(
                                  'Verify',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: _secondsLeft > 0
                            ? Text(
                                'Resend code in $_secondsLeft s',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.textSecondary),
                              )
                            : TextButton(
                                onPressed: () => _sendOtp(forceResend: true),
                                child: const Text(
                                  'Resend code',
                                  style: TextStyle(
                                    color: AppTheme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildBox(int i) {
    return SizedBox(
      width: 48,
      height: 58,
      child: TextField(
        controller: _controllers[i],
        focusNode: _focusNodes[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppTheme.surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primary, width: 2),
          ),
        ),
        onChanged: (v) {
          if (_error != null) setState(() => _error = null);
          if (v.isNotEmpty && i < 5) {
            _focusNodes[i + 1].requestFocus();
          } else if (v.isEmpty && i > 0) {
            _focusNodes[i - 1].requestFocus();
          }
          final code = _controllers.map((c) => c.text).join();
          if (code.length == 6) _verify();
        },
      ),
    );
  }
}