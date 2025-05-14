import 'package:flutter/material.dart';

sealed class Themes {

  static const Color kLightScaffoldColor = Color(0xFF1565C0);
  static const Color kLightPrimaryColor = Color(0xFF1565C0);

  static const Color kDarkScaffoldColor = Color(0xFF121212);
  static const Color kDarkPrimaryColor = Color(0xFF333333);


  static const Color kPrimaryColor = Color(0xFF2575FC);
  static const Color kSecondaryColor = Color(0xFFF95C54);
  static const Color kErrorBorderColor = Color(0xFFE74C3C);

  static const Color kTextColor = Color(0xFF333333);
  static const Color kTextLightColor = Color(0xFFAAAAAA);
  static const Color kOtherColor = Color(0xFF59C18D);

  // Base colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Light theme color scheme
  static var lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    onPrimary: white,
    secondary: kSecondaryColor,
    onSecondary: white,
    error: kErrorBorderColor,
    onError: white,
    surface: white,
    onSurface: kTextColor,
    surfaceTint: Color.alphaBlend(
      kPrimaryColor.withAlpha(26),
      Colors.transparent,
    ),
    outline: kTextColor.withAlpha(77),
    shadow: black.withAlpha(26),
  );

  // Dark theme color scheme
  static var darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: kPrimaryColor.withOpacity(0.8),
    onPrimary: black,
    secondary: kSecondaryColor.withOpacity(0.8),
    onSecondary: white,
    error: kErrorBorderColor,
    onError: white,
    surface: Colors.grey.shade900,
    onSurface: kTextLightColor,
    surfaceTint: Color.alphaBlend(
      kPrimaryColor.withAlpha(26),
      Colors.transparent,
    ),
    outline: Colors.grey.shade700,
    shadow: black,
  );

}

// Theme extensions for the app
