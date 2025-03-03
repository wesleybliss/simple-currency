import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a StateNotifier class to manage the theme mode
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system); // Default to system theme

  // @todo remember theme preference for subsequent launches

  void setThemeMode(ThemeMode newThemeMode) {
    if (newThemeMode == ThemeMode.system) {
      state = ThemeMode.system;
    } else {
      state = newThemeMode;
    }
  }

  void cycleNextTheme() {
    if (state == ThemeMode.system) {
      setThemeMode(getSystemBrightness() == Brightness.light
          ? ThemeMode.dark
          : ThemeMode.light);
    } else if (state == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.system);
    }
  }

  // Detect the current system brightness
  Brightness getSystemBrightness() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}

// Create a provider for the theme mode
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
