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

  static const Map<String, Color> animationColor = {
    'sides': Color.fromARGB(255, 243, 167, 80),
    'center': Color.fromARGB(255, 163, 110, 112)
  };

  static const List<List<Color>> petTiles = [
    [Color.fromARGB(255, 131, 158, 122), Colors.green, Colors.greenAccent],
    [
      Color.fromARGB(255, 243, 167, 80),
      Color.fromARGB(255, 224, 141, 47),
      Color.fromARGB(255, 255, 199, 116)
    ],
    [
      Color.fromARGB(255, 163, 110, 112),
      Color.fromARGB(255, 163, 78, 81),
      Color.fromARGB(255, 226, 150, 153)
    ]
  ];

  static const Color tile2 = Color.fromARGB(255, 97, 80, 85);
  static const Color form = Color.fromARGB(255, 199, 188, 192);
  static const Color navigation = Color.fromARGB(255, 180, 166, 171);
  static const Color darkerNavigation = Color.fromARGB(255, 162, 144, 150);
  static const Color buttons = Color.fromARGB(255, 148, 120, 121);
  static const Color field = Color.fromARGB(255, 242, 247, 244);
  static const Color background = Colors.white;

  static Color fromColor(Color color,
      {int a = -1, int r = -1, int g = -1, int b = -1}) {
    return Color.fromARGB(a > -1 ? a : color.alpha, r > -1 ? r : color.red,
        g > -1 ? g : color.green, b > -1 ? b : color.blue);
  }
}
