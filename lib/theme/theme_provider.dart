import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark);

  bool get isDarkMode {
    return state == ThemeMode.dark;
  }

  void toggle() {
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
}