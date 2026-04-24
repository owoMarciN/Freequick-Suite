import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/screens/users/main_screen.dart';
import 'package:user_app/screens/splash_screen.dart';

class SessionInitScreen extends StatefulWidget {
  final User user;
  const SessionInitScreen({super.key, required this.user});

  @override
  State<SessionInitScreen> createState() => SessionInitScreenState();
}

class SessionInitScreenState extends State<SessionInitScreen> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await widget.user.getIdToken(true);
    await sharedPreferences!.setString("uid", widget.user.uid);
    
    sessionReady = true;

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) => const MySplashScreen();
}