import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:user_app/screens/auth/auth_screen.dart';
import 'package:user_app/screens/users/main_screen.dart';
import 'package:user_app/services/app_storege_bridge.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:provider/provider.dart';
import 'package:user_app/providers/cart_provider.dart';
import 'package:shared_assets/providers/theme_provider.dart';
import 'package:user_app/providers/address_provider.dart';
import 'package:user_app/providers/amount_provider.dart';
import 'package:user_app/providers/locale_provider.dart';

import 'package:user_app/global/global.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_assets/models/language.dart';

import 'package:user_app/screens/splash_screen.dart';

import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

import 'package:shared_assets/l10n/l10n.dart';
import 'package:shared_assets/extensions/extensions.dart';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize SharedPreferences
  sharedPreferences = await SharedPreferences.getInstance();

  final storageBridge = AppStorageBridge();

  // Used to format the phone numbers
  await init();

  // Initialize Stripe
  Stripe.publishableKey =
      const String.fromEnvironment("STRIPE_PUBLISHABLE_KEY");
  await Stripe.instance.applySettings();

  // This needs to be here so that the user can login
  // After release change it to AndroidProvider.playIntegrity
  // MarcinDebugToken: 3770756b-47ff-40fc-b3ab-5dd0d0608ea6
  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(),
    providerApple: AppleDebugProvider(),
  );

  LocaleProvider localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  AddressProvider addressProvider = AddressProvider();
  await addressProvider.loadSavedAddress();

  CartProvider cartProvider = CartProvider();
  await cartProvider.loadCart();

  final themeProvider = ThemeProvider(storageBridge);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: addressProvider),
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: cartProvider),
        ChangeNotifierProvider(create: (c) => AmountProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Freequick Cunstomer',
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
        CustomerLocalizations.delegate,
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
            return const MySplashScreen();
          }
          if (snapshot.data == null) {
            return const AuthScreen();
          }
          return const MainScreen();
        },
      ),
    );
  }
}
