import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/screens/auth/auth_screen.dart';
import 'package:user_app/screens/users/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  void startTimer() {
    Timer(const Duration(seconds: 2), () {
      final user = firebaseAuth.currentUser;

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/1000021479.jpg',
                package: 'shared_assets',
                width: 300,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Freequick',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Train",
                package: 'shared_assets',
                letterSpacing: 3,
              ),
            ),
            const Text(
              "Wroclaw Number #1 Delivery App",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: "Signatra",
                package: 'shared_assets',
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}