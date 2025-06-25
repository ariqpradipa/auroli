import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeOption { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_preference';
  
  ThemeOption _themeOption = ThemeOption.system;
  late SharedPreferences _prefs;

  ThemeOption get themeOption => _themeOption;

  bool get isDarkMode {
    switch (_themeOption) {
      case ThemeOption.light:
        return false;
      case ThemeOption.dark:
        return true;
      case ThemeOption.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
  }

  ThemeMode get themeMode {
    switch (_themeOption) {
      case ThemeOption.light:
        return ThemeMode.light;
      case ThemeOption.dark:
        return ThemeMode.dark;
      case ThemeOption.system:
        return ThemeMode.system;
    }
  }

  Future<void> initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final themeIndex = _prefs.getInt(_themeKey) ?? ThemeOption.system.index;
    _themeOption = ThemeOption.values[themeIndex];
    notifyListeners();
  }

  Future<void> setTheme(ThemeOption themeOption) async {
    _themeOption = themeOption;
    await _prefs.setInt(_themeKey, themeOption.index);
    notifyListeners();
  }

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
