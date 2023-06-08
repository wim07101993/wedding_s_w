import 'package:flutter/material.dart';
import 'package:wedding_s_w/shared/resources/fonts.dart';

const _primaryColor = Color(0xFFDF8D53);
const _colors = ColorScheme(
  brightness: Brightness.light,
  primary: _primaryColor,
  onPrimary: Colors.white,
  secondary: Color(0xFF2A77BB),
  onSecondary: Colors.white,
  error: Color(0xFFD53A47),
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.white70,
  onSurface: Colors.black,
  surfaceTint: _primaryColor,
  surfaceVariant: Colors.green,
);

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _colors,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      fontSize: 52,
      color: _colors.primary,
    ),
    headlineSmall: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _colors.primary,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _colors.primary,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: _colors.primary,
    labelStyle: TextStyle(color: _colors.onPrimary),
    side: BorderSide.none,
  ),
);
