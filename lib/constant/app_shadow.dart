import 'package:flutter/material.dart';

class AppShadow {
  static List<BoxShadow> backgroundShadow = <BoxShadow>[
    BoxShadow(
        color: Colors.black.withOpacity(0.25),
        offset: const Offset(1, 5),
        blurRadius: 9),
    BoxShadow(
        color: Colors.black.withOpacity(0.25),
        offset: const Offset(0, -1),
        blurRadius: 12)
  ];
}
