import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier{
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  static const localeKey = 'locale';
  static const themeKey = 'theme_mode';


  SettingsNotifier() {
    _loadThemeFromPrefs();
  }

  void setLanguage(String languageCode)async{
    _locale = Locale(languageCode);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(localeKey, languageCode);
  }

  Future<void> _loadThemeFromPrefs()async{
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(themeKey) ?? 0;
    _themeMode = ThemeMode.values[themeModeIndex];

    final savedLanguageCode = prefs.getString(localeKey);
    if(savedLanguageCode != null){
      _locale = Locale(savedLanguageCode);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode)async{
    if(_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeKey, mode.index);
  }

  Future<void> toggleTheme()async{
    final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  bool _isBatterySaver = false;
  bool get isBatterySaver => _isBatterySaver;

  void toggleBatterySaver() {
    _isBatterySaver = !_isBatterySaver;
    notifyListeners();
  }

  bool isNotificationEnabled = true;
  String selectedNotificationSound = 'Default';

  void toggleNotification() {
    isNotificationEnabled = !isNotificationEnabled;
    notifyListeners();
  }

  void setNotificationSound(String sound) {
    selectedNotificationSound = sound;
    notifyListeners();
  }


}