import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:user_app/providers/address_provider.dart';
import 'package:user_app/providers/cart_provider.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/screens/splash_screen.dart';
import 'package:user_app/widgets/ui/auth_button.dart';

import 'package:shared_assets/widgets/dialogs/error_dialog.dart';
import 'package:shared_assets/widgets/dialogs/loading_dialog.dart';
import 'package:shared_assets/widgets/text_fields/custom_text_field.dart';
import 'package:shared_assets/widgets/text_fields/custom_password_field.dart';
import 'package:shared_assets/extensions/extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          LoadingDialog(message: context.l10nCommon.checkingCredentials),
    );

    try {
      final authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final User? currentUser = authResult.user;

      if (currentUser != null) {
        await _loadAndSaveUserData(currentUser);
      }

    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => ErrorDialog(
            message: error.message ?? context.l10nMerchant.errorLoginFailed),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => ErrorDialog(
            message: e.toString()),
      );
      ();
    }
  }

  Future<void> formValidation() async {
    if (_formKey.currentState!.validate()) {
      await _loginNow();
    } else {
      showDialog(
        context: context,
        builder: (_) =>
            ErrorDialog(message: context.l10nCommon.errorEnterEmailPassword),
      );
    }
  }

  Future<void> _loadAndSaveUserData(User currentUser) async {
    try {
      final userSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get();

      if (!userSnap.exists) {
        if (!mounted) return;
        return _failWith(context.l10nCommon.errorNoRecordFound);
      }

      final userData = userSnap.data()!;
      final String role = userData["role"]?.toString().toLowerCase() ?? "";
      final String status = userData["status"]?.toString().toLowerCase() ?? "";

      if (role != "customer" || status != "approved") {
        await firebaseAuth.signOut();
        throw Exception("ACCOUNT_BLOCKED");
      }

      // Save preferences
      await sharedPreferences!.setString("uid", currentUser.uid);
      await saveUserPref<String>("email", userData["email"]);
      await saveUserPref<String>("name", userData["name"]);
      await saveUserPref<String>("phone", userData["phone"]);
      await saveUserPref<String>("photoUrl", userData["photoUrl"]);

      // Init Providers
      if (!mounted) return;
      await Provider.of<CartProvider>(context, listen: false).loadCart();

      if (!mounted) return;
      await Provider.of<AddressProvider>(context, listen: false)
          .loadSavedAddress();

      if (!mounted) return;
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MySplashScreen()),
      );
    } catch (e) {
      if (firebaseAuth.currentUser != null) {
        await firebaseAuth.signOut();
      }
      if (!mounted) return;
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => ErrorDialog(message: e.toString()),
      );
    }
  }

  Future<void> _failWith(String message) async {
    await firebaseAuth.signOut();

    if (!mounted) return;

    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'images/login.png',
                        package: 'shared_assets',
                        height: 270,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              data: Icons.email,
                              controller: _emailController,
                              hintText: context.l10nCommon.email,
                              isObsecure: false,
                            ),
                            CustomPasswordField(
                              controller: _passwordController,
                              label: context.l10nCommon.password,
                              isRequired: true,
                              isConfirmation: true,
                            ),
                            const SizedBox(height: 10),
                            AuthButton(
                              label: context.l10nCommon.login,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                await formValidation();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
