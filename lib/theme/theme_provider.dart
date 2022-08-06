

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {

  ThemeNotifier(): super(ThemeMode.system);

  bool get isDarkMode {
    if (state == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return state == ThemeMode.dark;
    }
  }
  
  void toggle() {
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
}