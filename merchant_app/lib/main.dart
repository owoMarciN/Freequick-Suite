import 'package:flutter/material.dart';
import 'package:merchant_app/screens/landing/how_it_works_screen.dart';
import 'package:merchant_app/screens/restaurant/menus_screen.dart';
import 'package:merchant_app/screens/shell/orders_screen.dart';
import 'package:merchant_app/screens/shell/overview_screen.dart';
import 'package:merchant_app/screens/shell/promotion_screen.dart';
import 'package:merchant_app/screens/shell/settings_screen.dart';
import 'package:merchant_app/services/app_storage_bridge.dart';
import 'package:shared_assets/models/language.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:merchant_app/providers/providers_import.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchant_app/global/global.dart';
import 'package:go_router/go_router.dart';

import 'package:merchant_app/screens/auth/auth_screen.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';

import 'package:merchant_app/screens/landing/landing_page_screen.dart';
import 'package:merchant_app/screens/splash_screen.dart';
import 'package:merchant_app/screens/shell/dashboard_shell.dart';

import 'package:merchant_app/screens/shell/analytics_screen.dart';

import 'package:merchant_app/screens/landing/pricing_screen.dart';


import 'package:merchant_app/screens/admin/admin_import.dart';

import 'package:merchant_app/services/location_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:shared_assets/l10n/l10n.dart';
import 'package:shared_assets/extensions/extensions.dart';

import 'package:shared_assets/providers/theme_provider.dart';

import 'package:web/web.dart' as web;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await FirebaseAppCheck.instance.activate(
    providerWeb:
        ReCaptchaV3Provider("6LdxDXYsAAAAAMUEjjSL0wbJUGB3uYPPX8mzZoec"),
  );

  await init();

  sharedPreferences = await SharedPreferences.getInstance();

  final storageBridge = AppStorageBridge();



  injectGoogleMapsScript(LocationService.googleMapsApiKey);

  LocaleProvider localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  final themeProvider = ThemeProvider(storageBridge);

  setPathUrlStrategy();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(
            create: (_) => LocalStatsProvider(currentRestaurantUID ?? '')),
        ChangeNotifierProvider(create: (_) => GlobalStatsProvider()),
        ChangeNotifierProvider(
            create: (_) => MenuProvider(currentRestaurantUID ?? '')),
      ],
      child: const AdminApp(),
    ),
  );
}

// -- Navigator keys -----------------------------------------------------------
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _userShellKey =
    GlobalKey<NavigatorState>(debugLabel: 'userShell');
final GlobalKey<NavigatorState> _adminShellKey =
    GlobalKey<NavigatorState>(debugLabel: 'adminShell');

// -- Admin role check ---------------------------------------------------------
Future<String?> _adminRedirect(
    BuildContext context, GoRouterState state) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  // Not signed in at all
  if (uid == null) return '/auth/login';

  final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

  final role = doc.data()?['role']?.toString() ?? '';

  // Not an admin — send to restaurant dashboard
  if (role != 'admin') return '/dashboard';

  // Signed in as admin — allow through
  return null;
}

// -- Router -------------------------------------------------------------------
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    // -- Public ---------------------------------------------------------------
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/',
      builder: (context, state) => const LandingPageScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/splash',
      builder: (context, state) => const MySplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/auth/:mode',
      builder: (context, state) {
        final mode = state.pathParameters['mode'] ?? 'login';
        return AuthScreen(initialShowLogin: mode == 'login');
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/how-it-works',
      builder: (_, __) => const HowItWorksScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/pricing',
      builder: (_, __) => const PricingScreen(),
    ),

    // -- Restaurant dashboard -------------------------------------------------
    ShellRoute(
      navigatorKey: _userShellKey,
      builder: (context, state, child) => DashboardShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (_, __) => const OverviewScreen(),
        ),
        GoRoute(
          path: '/dashboard/orders',
          builder: (_, __) => const OrdersScreen(),
        ),
        GoRoute(
          path: '/dashboard/menus',
          builder: (_, __) => const MenusScreen(),
        ),
        GoRoute(
          path: '/dashboard/promotions',
          builder: (_, __) => const PromotionsScreen(),
        ),
        GoRoute(
          path: '/dashboard/analytics',
          builder: (_, __) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: '/dashboard/settings',
          builder: (_, __) => const SettingsScreen(),
        ),
      ],
    ),

    // -- Admin panel ----------------------------------------------------------
    ShellRoute(
      navigatorKey: _adminShellKey,
      redirect: _adminRedirect,
      builder: (context, state, child) => AdminDashboardShell(child: child),
      routes: [
        GoRoute(
          path: '/admin/overview',
          builder: (_, __) => const AdminOverviewScreen(),
        ),
        GoRoute(
          path: '/admin/join-requests',
          builder: (_, __) => const JoinRequestsScreen(),
        ),
        GoRoute(
          path: '/admin/users',
          builder: (_, __) => const UserManagementScreen(),
        ),
        GoRoute(
          path: '/admin/notifications',
          builder: (_, __) => const AdminNotificationsScreen(),
        ),
      ],
    ),
  ],
);

// -- App ----------------------------------------------------------------------
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,

      routerConfig: _router,

      title: 'Freequick Merchant',
      debugShowCheckedModeBanner: false,

      locale: localeProvider.locale,

      supportedLocales: Language.languageList.map((lang) {
        return Locale(lang.code, lang.countryCode);
      }).toList(),

      localizationsDelegates: const [
        CommonLocalizations.delegate,
        MerchantLocalizations.delegate,
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
    );
  }
}

// -- Google Maps script injection ---------------------------------------------
void injectGoogleMapsScript(String apiKey) {
  const scriptId = 'google-maps-sdk';

  if (web.document.getElementById(scriptId) == null) {
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    script.id = scriptId;
    script.src =
        'https://maps.googleapis.com/maps/api/js?key=$apiKey&libraries=places';
    script.async = true;
    script.defer = true;
    web.document.head?.appendChild(script);
  }
}
