import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/extensions/brand_color_ext.dart';
import 'package:rider_app/l10n/app_localizations.dart';
import 'package:rider_app/models/language_model.dart';
import 'package:rider_app/providers/locale_provider.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:rider_app/utils/app_constants.dart';
import 'package:rider_app/widgets/unified_snackbar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global/global.dart';
import 'screens/auth/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedPreferences = await SharedPreferences.getInstance();

  // Load locale first
  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  // Init rider provider
  final riderProvider = RiderProvider();
  riderProvider.init(); // will start listening to auth & Firestore

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: riderProvider),
        ChangeNotifierProxyProvider<RiderProvider, RiderStatsProvider>(
          create: (_) => RiderStatsProvider(''), 
          update: (context, riderProv, previous) {
            final uid = riderProv.rider?.uid ?? '';

            if (previous != null && previous.riderUID == uid) {
              return previous;
            }
            return RiderStatsProvider(uid);
          },
        ),
      ],
      child: const RiderApp(),
    ),
  );
}

class RiderApp extends StatelessWidget {
  const RiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: snackBarNavigatorKey,
      theme: darkTheme,
      locale: localeProvider.locale,
      supportedLocales: Language.languageList.map(
        (lang) => Locale(lang.code, lang.countryCode),
      ).toList(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return supportedLocales.first;
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) return supportedLocale;
        }
        return supportedLocales.first;
      },
      home: StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { return const CircularProgressIndicator(); }
          if (snapshot.data == null) { return const LoginScreen(); }
          return const MainScreen();
        },
      ),
    );
  }
}
