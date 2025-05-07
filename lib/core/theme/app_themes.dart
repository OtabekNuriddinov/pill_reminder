import 'package:flutter/material.dart';
import 'package:medicine_reminder/core/theme/themes.dart';

sealed class AppThemes {

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: Themes.lightColorScheme,
    scaffoldBackgroundColor: Themes.white,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: Themes.darkColorScheme,
    scaffoldBackgroundColor: Color(0xFF121212),
  );
}