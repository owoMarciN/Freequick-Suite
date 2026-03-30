import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/extensions/brand_color_ext.dart';
import 'package:rider_app/l10n/app_localizations.dart';
import 'package:rider_app/models/language.dart';
import 'package:rider_app/providers/locale_provider.dart';
import 'package:rider_app/utils/app_constants.dart';
import 'package:rider_app/widgets/unified_snackbar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/app_theme.dart';
import 'global/global.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/active_delivery_screen.dart';
import 'screens/auth/profile_setup_screen.dart';
import 'screens/profile_screen.dart';

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
      home: const _AppRouter(),
    );
  }
}

//  Router decides which main screen to show based on RiderProvider.appState
class _AppRouter extends StatelessWidget {
  const _AppRouter();

  @override
  Widget build(BuildContext context) {
    final riderProvider = context.watch<RiderProvider>();

    switch (riderProvider.appState) {
      case RiderAppState.loading:
        return const _SplashScreen();
      case RiderAppState.unauthenticated:
        return const LoginScreen();
      case RiderAppState.needsProfile:
        return const ProfileSetupScreen();
      case RiderAppState.idle:
      case RiderAppState.onJob:
        if (riderProvider.rider == null) {
          return const _SplashScreen();
        }
        return ChangeNotifierProvider(
          key: ValueKey(riderProvider.rider!.uid),
          create: (_) => RiderStatsProvider(riderProvider.rider!.uid),
          child: riderProvider.appState == RiderAppState.onJob
              ? const ActiveDeliveryScreen()
              : const _RiderShell(),
        );
    }
  }
}

//  Shell with bottom navigation (Home + Profile)
class _RiderShell extends StatefulWidget {
  const _RiderShell();

  @override
  State<_RiderShell> createState() => _RiderShellState();
}

class _RiderShellState extends State<_RiderShell> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: AppTheme.surface,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//  Splash screen
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delivery_dining_rounded, color: AppTheme.primary, size: 64),
            SizedBox(height: 20),
            CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}