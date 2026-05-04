import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:shared_assets/models/language.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:shared_assets/utils/app_constants.dart';
import 'package:rider_app/providers/locale_provider.dart';
import 'package:rider_app/services/app_storage_bridge.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'firebase_options.dart';
import 'package:rider_app/global/global.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/screens/auth/login_screen.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_assets/l10n/l10n.dart';
import 'package:shared_assets/providers/theme_provider.dart';
import 'package:shared_assets/extensions/extensions.dart';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  sharedPreferences = await SharedPreferences.getInstance();

  final storageBridge = AppStorageBridge();

  final themeProvider = ThemeProvider(storageBridge);

  // Initialization of the phone number formatter
  await init();

  // Init locale (language) provider
  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  // Init rider provider
  final riderProvider = RiderProvider();
  riderProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: riderProvider),
        ChangeNotifierProvider.value(value: themeProvider),
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: snackBarNavigatorKey,
      
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,

      locale: localeProvider.locale,

      supportedLocales: Language.languageList.map((lang) {
        return Locale(lang.code, lang.countryCode);
      }).toList(),

      localizationsDelegates: const [
        CommonLocalizations.delegate,
        RiderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return supportedLocales.first;
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data == null) {
            return const LoginScreen();
          }
          return const MainScreen();
        },
      ),
    );
  }
}
