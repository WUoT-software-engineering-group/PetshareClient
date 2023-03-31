import 'package:flutter/material.dart';

class AppColors {
  static const Map<String, Color> smallElements = {
    'greenish': Color.fromARGB(255, 131, 158, 122),
    'reddish': Color.fromARGB(255, 79, 64, 69)
  };

  static const List<Color> tile = [
    Color.fromARGB(150, 52, 62, 61),
    Color.fromARGB(255, 97, 80, 85)
  ];
  static const Color tile2 = Color.fromARGB(255, 97, 80, 85);
  static const Color form = Color.fromARGB(255, 199, 188, 192);
  static const Color navigation = Color.fromARGB(255, 180, 166, 171);
  static const Color darkerNavigation = Color.fromARGB(255, 162, 144, 150);
  static const Color buttons = Color.fromARGB(255, 148, 120, 121);
  static const Color background = Color.fromARGB(255, 242, 247, 244);

  static Color fromColor(Color color,
      {int a = -1, int r = -1, int g = -1, int b = -1}) {
    return Color.fromARGB(a > -1 ? a : color.alpha, r > -1 ? r : color.red,
        g > -1 ? g : color.green, b > -1 ? b : color.blue);
  }
}
