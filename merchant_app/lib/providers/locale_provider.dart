import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_assets/models/language.dart';
import 'package:merchant_app/global/global.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    final isSupported = Language.languageList.any(
      (lang) => lang.code == locale.languageCode,
    );
    if (!isSupported) return;

    _locale = locale;
    notifyListeners();

    await saveUserPref<String>('language_code', locale.languageCode);
    await _syncLocaleToFirestore(locale.languageCode);
  }

  Future<void> loadLocale() async {
    String? languageCode = getUserPref<String>('language_code');

    if (languageCode == null) {
      final String deviceCode =
          PlatformDispatcher.instance.locale.languageCode;
      final isSupported = Language.languageList.any(
        (lang) => lang.code == deviceCode,
      );
      languageCode = isSupported ? deviceCode : 'en';
    }

    _locale = Locale(languageCode);
    notifyListeners();

    // Sync on load in case the User reinstalled or cleared prefs
    await _syncLocaleToFirestore(languageCode);
  }

  void reset() {
    _locale = const Locale('en');
    notifyListeners();
  }

  Future<void> _syncLocaleToFirestore(String languageCode) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'locale': languageCode});
    } catch (_) {
      // User document may not exist yet — use set with merge as fallback
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({'locale': languageCode}, SetOptions(merge: true));
      } catch (e) {
        debugPrint('LocaleProvider: failed to sync locale to Firestore: $e');
      }
    }
  }
}
