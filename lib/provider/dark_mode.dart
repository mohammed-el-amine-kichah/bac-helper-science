import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  static const _darkModeKey = 'darkMode';
  bool get isDarkMode => _isDarkMode;


  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_darkModeKey) ?? false;
    notifyListeners();
  }
  ThemeNotifier() {
    _loadTheme();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = !_isDarkMode;
    await prefs.setBool(_darkModeKey, _isDarkMode);
    notifyListeners();
  }
}
