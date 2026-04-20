import 'package:flutter/material.dart';
import '../interfaces/i_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final IStorage storage;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider(this.storage) {
    _loadInitialTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void _loadInitialTheme() {
    final String? saved = storage.getPref<String>("theme_mode");
    if (saved == "dark") {
      _themeMode = ThemeMode.dark;
    } else if (saved == "light") {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    
    await storage.savePref<String>("theme_mode", mode.name);
    notifyListeners();
  }

  Future<void> toggle(BuildContext context) async {
    final bool currentlyDark = _themeMode == ThemeMode.dark || 
        (_themeMode == ThemeMode.system && 
         MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    
    await setThemeMode(currentlyDark ? ThemeMode.light : ThemeMode.dark);
  }
}