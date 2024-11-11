import 'package:flutter/material.dart';

abstract class BaseAppTheme {
  Color primary = const Color(0xFF2384BA);

  Color black = Colors.black;
  Color white = Colors.white;
}

class LightTheme extends BaseAppTheme {}

class DarkTheme extends BaseAppTheme {}
