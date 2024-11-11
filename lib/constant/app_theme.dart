import 'package:flutter/material.dart';
import 'package:weather_switch/constant/base_app_theme.dart';

class AppTheme {
  final _lightTheme = LightTheme();
  final _dark = DarkTheme();

  late final lightTheme = ThemeData(
      primaryColor: _lightTheme.primary, shadowColor: _lightTheme.black);

  late final darkTheme =
      ThemeData(primaryColor: _dark.primary, shadowColor: _dark.black);

  final themeMode = ValueNotifier(ThemeMode.system);

  setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }
}
