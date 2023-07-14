import 'package:flutter/material.dart';
import 'package:wedding_s_w/shared/resources/fonts.dart';

const _primaryColor = Color(0xFF84B370);
const _secondaryColor = Color(0xFFDF8D53);
const _colors = ColorScheme(
  brightness: Brightness.light,
  primary: _primaryColor,
  onPrimary: Colors.white,
  secondary: _secondaryColor,
  onSecondary: Colors.white,
  error: Color(0xFFD53A47),
  onError: Colors.white,
  background: Colors.transparent,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  surfaceTint: _primaryColor,
  surfaceVariant: Colors.green,
);

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _colors,
  dividerTheme: const DividerThemeData(color: Colors.black26),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.black38),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      fontSize: 52,
      color: _colors.secondary,
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
    backgroundColor: _colors.primary.withOpacity(0.6),
    labelStyle: TextStyle(color: _colors.onPrimary),
    side: BorderSide.none,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
);
