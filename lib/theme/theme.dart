import 'package:flutter/material.dart';

class CustomThemes {
  static final light = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF006DE3),
        secondary: Colors.white,
        onSecondary: Color(0xFF9096A0),
        tertiary: Color(0xFF00C0E8),
      ));

  static final dark = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF1C2939),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF0b80ff),
        onPrimary: Colors.white,
        secondary: Color(0xFF1C2939),
        onSecondary: Colors.white,
        tertiary: Color(0xFF00C0E8),
      ));
}
