import 'dart:io';
import 'package:flutter/material.dart';

import 'package:user_app/screens/otp_screen.dart';
import 'package:user_app/services/image_picker_service.dart';

import 'package:phone_form_field/phone_form_field.dart';

import 'package:user_app/widgets/auth_button.dart';
import 'package:user_app/widgets/custom_text_field.dart';
import 'package:user_app/widgets/error_dialog.dart';
import 'package:user_app/widgets/loading_dialog.dart';
import 'package:user_app/widgets/custom_phone_field.dart';
import 'package:user_app/widgets/custom_password_field.dart';

import 'package:user_app/extensions/context_translate_ext.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmePasswordController =
      TextEditingController();
  late final PhoneController _phoneController;

  File? _croppedImage;

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.PL, nsn: ''),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmePasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    final file = await ImagePickerService.pickAndCrop(context);
    if (file != null) setState(() => _croppedImage = file);
  }

  // -- Validation -------------------------------------------------------------
  Future<void> _submit() async {
    if (_croppedImage == null) {
      showDialog(
          context: context,
          builder: (_) => ErrorDialog(message: context.l10n.errorSelectImage));
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmePasswordController.text) {
      showDialog(
          context: context,
          builder: (_) =>
              ErrorDialog(message: context.l10n.errorNoMatchPasswords));
      return;
    }

    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
          LoadingDialog(message: context.l10n.registeringAccount)
      );
      return;
    }

    // Pass everything to OtpScreen.
    // OtpScreen will:
    //   1. Send OTP to the phone number
    //   2. Verify the code
    //   3. Create the email/password account
    //   4. Link the phone credential to it
    //   5. Upload the photo
    //   6. Save to Firestore + SharedPreferences
    //   7. Navigate to MainScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(
          args: OtpScreenArgs(
            name:     _nameController.text.trim(),
            email:    _emailController.text.trim(),
            password: _passwordController.text,
            phone:    _phoneController.value.international,
            photo:    _croppedImage!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 16),

                // Avatar picker
                GestureDetector(
                  onTap: _getImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.20,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _croppedImage != null
                            ? FileImage(_croppedImage!)
                            : null,
                        child: _croppedImage == null
                            ? Icon(
                                Icons.add_photo_alternate_rounded,
                                size: MediaQuery.of(context).size.width * 0.18,
                                color: Colors.grey[400],
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade300,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit_rounded,
                              size: 24, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          data: Icons.person,
                          controller: _nameController,
                          hintText: context.l10n.hintName,
                          isObsecure: false,
                        ),
                        CustomPhoneField(
                          controller: _phoneController,
                          label: context.l10n.hintPhone,
                        ),
                        CustomTextField(
                          data: Icons.email,
                          controller: _emailController,
                          hintText: context.l10n.hintEmail,
                          isObsecure: false,
                        ),
                        CustomPasswordField(
                          controller: _passwordController,
                          label: context.l10n.hintPassword,
                          isRequired: true,
                          isConfirmation: false,
                        ),
                        CustomPasswordField(
                          controller: _confirmePasswordController,
                          label: context.l10n.hintConfPassword,
                          isRequired: true,
                          isConfirmation: true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                AuthButton(
                  label: context.l10n.signUp,
                  onPressed: () async => await _submit(),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
