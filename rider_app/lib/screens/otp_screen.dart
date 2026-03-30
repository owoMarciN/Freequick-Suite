import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String name;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.name,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? _verificationId;
  int? _resendToken;

  bool _loading = true;
  bool _verifying = false;

  final List<TextEditingController> _otp =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focus =
      List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  Future<void> _sendOtp({bool forceResend = false}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      forceResendingToken: forceResend ? _resendToken : null,
      timeout: const Duration(seconds: 60),

      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        await _saveUser();
        if (!mounted) return;
        Navigator.popUntil(context, (route) => route.isFirst);
      },

      verificationFailed: (e) {
        if (!mounted) return;
        setState(() => _loading = false);
      },

      codeSent: (verificationId, resendToken) {
        if (!mounted) return;
        setState(() {
          _verificationId = verificationId;
          _resendToken = resendToken;
          _loading = false;
        });
      },

      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _verify() async {
    final code = _otp.map((c) => c.text).join();

    if (code.length < 6 || _verificationId == null) return;

    setState(() => _verifying = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      await _auth.signInWithCredential(credential);
      await _saveUser();

      if (!mounted) return;

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      setState(() => _verifying = false);
    }
  }

  Future<void> _saveUser() async {
    final uid = _auth.currentUser!.uid;

    await _db.collection("users").doc(uid).set({
      "name": widget.name,
      "phone": widget.phoneNumber,
      "createdAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  void dispose() {
    for (final c in _otp) {
      c.dispose();
    }
    for (final f in _focus) {
      f.dispose();
    }
    super.dispose();
  }

  Widget _otpBox(int i) {
    return SizedBox(
      width: 55,
      height: 65,
      child: TextField(
        controller: _otp[i],
        focusNode: _focus[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        onChanged: (v) {
          if (v.isNotEmpty && i < 5) {
            _focus[i + 1].requestFocus();
          } else if (v.isEmpty && i > 0) {
            _focus[i - 1].requestFocus();
          }

          final code = _otp.map((c) => c.text).join();
          if (code.length == 6) _verify();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    "Enter OTP",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, _otpBox),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifying ? null : _verify,
                      child: _verifying
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Verify"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () => _sendOtp(forceResend: true),
                    child: const Text("Resend code"),
                  ),
                ],
              ),
            ),
    );
  }
}