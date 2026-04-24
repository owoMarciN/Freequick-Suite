import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:user_app/providers/address_provider.dart';
import 'package:user_app/providers/cart_provider.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/screens/users/main_screen.dart';
import 'package:user_app/widgets/ui/auth_button.dart';

import 'package:shared_assets/widgets/dialogs/error_dialog.dart';
import 'package:shared_assets/widgets/dialogs/loading_dialog.dart';
import 'package:shared_assets/widgets/text_fields/custom_text_field.dart';
import 'package:shared_assets/widgets/text_fields/custom_password_field.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';
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

  Future<void> loginNow() async {
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

      final currentUser = authResult.user;
      if (currentUser == null) {
        if (!mounted) return;
        throw Exception(context.l10nCommon.errorLoginFailed);
      }

      await readDataAndSetDataLocally(currentUser);

      if (!mounted) return;
      Navigator.pop(context);

      await Future.delayed(const Duration(milliseconds: 150));

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );

    } on FirebaseAuthException catch (error) {
      _handleErrorUI(error.message ?? context.l10nCommon.errorLoginFailed);
    } catch (e) {
      _handleErrorUI(e.toString());
    }
  }

  // Helper method to cleanly close the dialog and show the error
  void _handleErrorUI(String errorMessage) {
    if (!mounted) return;
    Navigator.pop(context); // Always dismiss the loading dialog

    // Custom handling for the blocked account thrown from below
    if (errorMessage.contains("ACCOUNT_BLOCKED")) {
      unifiedSnackBar(context.l10nCommon.errorAccountBlocked, error: true);
    } else {
      showDialog(
        context: context,
        builder: (_) =>
            ErrorDialog(message: errorMessage.replaceAll("Exception: ", "")),
      );
    }
  }

  Future<void> formValidation() async {
    if (_formKey.currentState!.validate()) {
      await loginNow();
    } else {
      showDialog(
        context: context,
        builder: (_) =>
            ErrorDialog(message: context.l10nCommon.errorEnterEmailPassword),
      );
    }
  }

  Future<void> readDataAndSetDataLocally(User currentUser) async {
    // Force token refresh to ensure Firestore rules see the latest auth state
    await currentUser.getIdToken(true);

    await sharedPreferences!.setString("uid", currentUser.uid);

    final docRef =
        FirebaseFirestore.instance.collection("users").doc(currentUser.uid);
    final snapshot =
        await docRef.get(const GetOptions(source: Source.serverAndCache));

    if (!snapshot.exists) {
      await firebaseAuth.signOut();
      await sharedPreferences!.remove("uid");
      throw Exception(context.l10nCommon.errorNoRecordFound);
    }

    final data = snapshot.data()!;
    if (data["role"] != "customer" || data["status"] != "approved") {
      await firebaseAuth.signOut();
      await sharedPreferences!.remove("uid");
      throw Exception("ACCOUNT_BLOCKED"); // Caught by loginNow()
    }

    // Save preferences
    await saveUserPref<String>("email", data["email"]);
    await saveUserPref<String>("name", data["name"]);
    await saveUserPref<String>("phone", data["phone"]);
    await saveUserPref<String>("photoUrl", data["photoUrl"]);

    // Init Providers
    if (!mounted) return;
    await Provider.of<CartProvider>(context, listen: false).loadCart();

    // CRITICAL: If loadSavedAddress() returns a Future, you MUST await it
    // to guarantee it finishes before navigating to MainScreen.
    if (!mounted) return;
    await Provider.of<AddressProvider>(context, listen: false)
        .loadSavedAddress();

    sessionReady = true;
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
