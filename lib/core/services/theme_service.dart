import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static final ThemeService instance = ThemeService._();
  ThemeService._();

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  // Clé pour le stockage local
  static const String _themeKey = "user_theme_pref";

  // Initialisation au démarrage de l'app
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme == "dark") {
      _themeMode = ThemeMode.dark;
    } else if (savedTheme == "custom") {
      _themeMode = ThemeMode.system; // On utilise system pour représenter le "Personnalisé" ici
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  // Changer le thème
  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String value = "light";
    if (mode == ThemeMode.dark) value = "dark";
    if (mode == ThemeMode.system) value = "custom";
    await prefs.setString(_themeKey, value);
  }
}