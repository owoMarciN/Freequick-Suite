// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================
// Brand Color Extension
// =============================================

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  final Color? primary;
  final Color? primaryDark;
  final Color? primarySoft;
  final Color? danger;
  final Color? dangerDark;
  final Color? dangerSoft;
  final Color? success;
  final Color? successSoft;
  final Color? warning;
  final Color? muted;
  final Color? cardSurface;
  final Color? cardBorder;

  const BrandColors({
    this.primary,
    this.primaryDark,
    this.primarySoft,
    this.danger,
    this.dangerDark,
    this.dangerSoft,
    this.success,
    this.successSoft,
    this.warning,
    this.muted,
    this.cardSurface,
    this.cardBorder,
  });

  @override
  BrandColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? primarySoft,
    Color? danger,
    Color? dangerDark,
    Color? dangerSoft,
    Color? success,
    Color? successSoft,
    Color? warning,
    Color? muted,
    Color? cardSurface,
    Color? cardBorder,
  }) {
    return BrandColors(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primarySoft: primarySoft ?? this.primarySoft,
      danger: danger ?? this.danger,
      dangerDark: dangerDark ?? this.dangerDark,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      warning: warning ?? this.warning,
      muted: muted ?? this.muted,
      cardSurface: cardSurface ?? this.cardSurface,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      primary: Color.lerp(primary, other.primary, t),
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t),
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t),
      danger: Color.lerp(danger, other.danger, t),
      dangerDark: Color.lerp(dangerDark, other.dangerDark, t),
      dangerSoft: Color.lerp(dangerSoft, other.dangerSoft, t),
      success: Color.lerp(success, other.success, t),
      successSoft: Color.lerp(successSoft, other.successSoft, t),
      warning: Color.lerp(warning, other.warning, t),
      muted: Color.lerp(muted, other.muted, t),
      cardSurface: Color.lerp(cardSurface, other.cardSurface, t),
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t),
    );
  }
}

extension BrandColorsContext on BuildContext {
  BrandColors get brand => Theme.of(this).extension<BrandColors>()!;
}

// =============================================
// Color pallete
// =============================================

abstract class _AppPalette {
  // Blue
  static const blue500 = Color(0xFF2563EB);
  // ignore: unused_field
  static const blue600 = Color(0xFF1D4ED8);
  static const blue700 = Color(0xFF1E3A8A);
  static const blue900 = Color(0xFF0F1F4A);
  static const blueSoft = Color(0xFFDCEAFE); // light only
  static const blueSoftDark = Color(0xFF1E2D50); // dark only

  // Red
  static const red500 = Color(0xFFEF4444);
  // ignore: unused_field
  static const red600 = Color(0xFFDC2626);
  static const red700 = Color(0xFFB91C1C);
  static const redSoft = Color(0xFFFFE4E4); // light only
  static const redSoftDark = Color(0xFF3B1414); // dark only

  // Green
  static const green500 = Color(0xFF10B981);
  static const greenSoft = Color(0xFFD1FAE5);
  static const greenSoftDark = Color(0xFF0D2B1F);

  // Warning
  static const amber500 = Color(0xFFF59E0B);

  // Neutrals — Light
  static const white = Color(0xFFFFFFFF);
  static const grey50 = Color(0xFFF8F9FC);
  static const grey100 = Color(0xFFF0F2F8);
  static const grey200 = Color(0xFFE2E6F0);
  static const grey400 = Color(0xFF94A3B8);
  static const grey600 = Color(0xFF475569);
  static const grey900 = Color(0xFF0F172A);

  // Neutrals — Dark
  static const dark900 = Color(0xFF0D0F1E); // scaffold
  static const dark800 = Color(0xFF13162A); // surface / card
  static const dark700 = Color(0xFF1A1E35); // surfaceBright
  static const dark600 = Color(0xFF222640); // borders
  static const dark400 = Color(0xFF8A92B2); // muted text
}

// =============================================
// Light Theme
// =============================================

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: _AppPalette.grey50,
  colorScheme: const ColorScheme.light(
    primary: _AppPalette.blue500,
    onPrimary: _AppPalette.white,
    primaryContainer: _AppPalette.blueSoft,
    onPrimaryContainer: _AppPalette.blue700,
    secondary: _AppPalette.red500,
    onSecondary: _AppPalette.white,
    secondaryContainer: _AppPalette.redSoft,
    onSecondaryContainer: _AppPalette.red700,
    surface: _AppPalette.white,
    surfaceBright: _AppPalette.grey100,
    onSurface: _AppPalette.grey900,
    onSurfaceVariant: _AppPalette.grey600,
    outline: _AppPalette.grey200,
    outlineVariant: _AppPalette.grey100,
    error: _AppPalette.red500,
    onError: _AppPalette.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: _AppPalette.white,
    foregroundColor: _AppPalette.grey900,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      color: _AppPalette.grey900,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
    ),
    iconTheme: IconThemeData(color: _AppPalette.grey900),
  ),
  cardTheme: CardThemeData(
    color: _AppPalette.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: _AppPalette.grey200),
    ),
    margin: EdgeInsets.zero,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: _AppPalette.blue500,
      foregroundColor: _AppPalette.white,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _AppPalette.blue500,
      side: const BorderSide(color: _AppPalette.blue500),
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _AppPalette.blue500,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _AppPalette.grey100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.grey200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.grey200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.blue500, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.red500),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: const TextStyle(color: _AppPalette.grey400, fontSize: 14),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: _AppPalette.grey100,
    selectedColor: _AppPalette.blueSoft,
    labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    side: const BorderSide(color: _AppPalette.grey200),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return _AppPalette.white;
      return _AppPalette.grey400;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return _AppPalette.blue500;
      return _AppPalette.grey200;
    }),
  ),
  dividerTheme: const DividerThemeData(
    color: _AppPalette.grey200,
    thickness: 1,
    space: 1,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _AppPalette.white,
    selectedItemColor: _AppPalette.blue500,
    unselectedItemColor: _AppPalette.grey400,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: _AppPalette.white,
    indicatorColor: _AppPalette.blueSoft,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: _AppPalette.blue500);
      }
      return const IconThemeData(color: _AppPalette.grey400);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: _AppPalette.blue500,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        );
      }
      return const TextStyle(color: _AppPalette.grey400, fontSize: 12);
    }),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: _AppPalette.grey900,
        letterSpacing: -0.5),
    displayMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: _AppPalette.grey900,
        letterSpacing: -0.3),
    titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _AppPalette.grey900,
        letterSpacing: -0.2),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: _AppPalette.grey900),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: _AppPalette.grey900),
    bodyLarge: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, color: _AppPalette.grey900),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: _AppPalette.grey600),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: _AppPalette.grey400),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: _AppPalette.grey900),
    labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: _AppPalette.grey400,
        letterSpacing: 0.4),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    BrandColors(
      primary: _AppPalette.blue500,
      primaryDark: _AppPalette.blue700,
      primarySoft: _AppPalette.blueSoft,
      danger: _AppPalette.red500,
      dangerDark: _AppPalette.red700,
      dangerSoft: _AppPalette.redSoft,
      success: _AppPalette.green500,
      successSoft: _AppPalette.greenSoft,
      warning: _AppPalette.amber500,
      muted: _AppPalette.grey400,
      cardSurface: _AppPalette.white,
      cardBorder: _AppPalette.grey200,
    ),
  ],
);

// =============================================
// Dark Theme
// =============================================

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _AppPalette.dark900,
  colorScheme: const ColorScheme.dark(
    primary: _AppPalette.blue500,
    onPrimary: _AppPalette.white,
    primaryContainer: _AppPalette.blueSoftDark,
    onPrimaryContainer: _AppPalette.blueSoft,
    secondary: _AppPalette.red500,
    onSecondary: _AppPalette.white,
    secondaryContainer: _AppPalette.redSoftDark,
    onSecondaryContainer: _AppPalette.redSoft,
    surface: _AppPalette.dark800,
    surfaceBright: _AppPalette.dark700,
    onSurface: _AppPalette.white,
    onSurfaceVariant: _AppPalette.dark400,
    outline: _AppPalette.dark600,
    outlineVariant: _AppPalette.dark700,
    error: _AppPalette.red500,
    onError: _AppPalette.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: _AppPalette.dark800,
    foregroundColor: _AppPalette.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: TextStyle(
      color: _AppPalette.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
    ),
    iconTheme: IconThemeData(color: _AppPalette.white),
  ),
  cardTheme: CardThemeData(
    color: _AppPalette.dark800,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: _AppPalette.dark600),
    ),
    margin: EdgeInsets.zero,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: _AppPalette.blue500,
      foregroundColor: _AppPalette.white,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _AppPalette.blue500,
      side: const BorderSide(color: _AppPalette.blue500),
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _AppPalette.blue500,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _AppPalette.dark700,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.dark600),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.dark600),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.blue500, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _AppPalette.red500),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: const TextStyle(color: _AppPalette.dark400, fontSize: 14),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: _AppPalette.dark700,
    selectedColor: _AppPalette.blueSoftDark,
    labelStyle: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: _AppPalette.white),
    side: const BorderSide(color: _AppPalette.dark600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return _AppPalette.white;
      return _AppPalette.dark400;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return _AppPalette.blue500;
      return _AppPalette.dark600;
    }),
  ),
  dividerTheme: const DividerThemeData(
    color: _AppPalette.dark600,
    thickness: 1,
    space: 1,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _AppPalette.dark800,
    selectedItemColor: _AppPalette.blue500,
    unselectedItemColor: _AppPalette.dark400,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: _AppPalette.dark800,
    indicatorColor: _AppPalette.blueSoftDark,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: _AppPalette.blue500);
      }
      return const IconThemeData(color: _AppPalette.dark400);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: _AppPalette.blue500,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        );
      }
      return const TextStyle(color: _AppPalette.dark400, fontSize: 12);
    }),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: _AppPalette.white,
        letterSpacing: -0.5),
    displayMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: _AppPalette.white,
        letterSpacing: -0.3),
    titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _AppPalette.white,
        letterSpacing: -0.2),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: _AppPalette.white),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: _AppPalette.white),
    bodyLarge: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, color: _AppPalette.white),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: _AppPalette.dark400),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: _AppPalette.dark400),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: _AppPalette.white),
    labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: _AppPalette.dark400,
        letterSpacing: 0.4),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    BrandColors(
      primary: _AppPalette.blue500,
      primaryDark: _AppPalette.blue900,
      primarySoft: _AppPalette.blueSoftDark,
      danger: _AppPalette.red500,
      dangerDark: _AppPalette.red700,
      dangerSoft: _AppPalette.redSoftDark,
      success: _AppPalette.green500,
      successSoft: _AppPalette.greenSoftDark,
      warning: _AppPalette.amber500,
      muted: _AppPalette.dark400,
      cardSurface: _AppPalette.dark800,
      cardBorder: _AppPalette.dark600,
    ),
  ],
);
