import 'package:flutter/material.dart';

import '../../data/datasource/local_database.dart';

enum AppThemeMode { dark, light, system }

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  AppThemeMode _appThemeMode = AppThemeMode.dark;

  AppThemeMode get appThemeMode => _appThemeMode;

  ThemeMode get themeMode {
    switch (_appThemeMode) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> setTheme(AppThemeMode mode) async {
    _appThemeMode = mode;
    notifyListeners();
    await prefs?.setInt(_themeKey, mode.index);
  }

  Future<void> _loadTheme() async {
    final index = prefs?.getInt(_themeKey);
    _appThemeMode = AppThemeMode.values[index ?? AppThemeMode.system.index];
    debugPrint("theme mode : ===> ${_appThemeMode.name}");
    notifyListeners();
  }
}
