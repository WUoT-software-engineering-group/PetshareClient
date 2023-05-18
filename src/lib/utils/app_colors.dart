import 'package:flutter/material.dart';

class AppColors {
  static const Map<String, Color> smallElements = {
    'greenish': Color.fromARGB(255, 131, 158, 122),
    'reddish': Color.fromARGB(255, 79, 64, 69)
  };

  static const Map<String, Color> animationColor = {
    'sides': Color.fromARGB(255, 243, 167, 80),
    'center': Color.fromRGBO(216, 209, 255, 1)
  };

  static const List<List<Color>> petTiles = [
    [
      Color.fromARGB(255, 131, 158, 122),
      Color.fromARGB(255, 64, 94, 54),
      Color.fromARGB(255, 19, 36, 14)
    ],
    [
      Color.fromARGB(255, 206, 159, 105),
      Color.fromARGB(255, 215, 151, 77),
      Color.fromARGB(255, 155, 108, 55)
    ],
    [
      Color.fromARGB(255, 163, 110, 112),
      Color.fromARGB(255, 153, 67, 70),
      Color.fromARGB(255, 136, 44, 47),
    ],
    [
      Color.fromARGB(255, 33, 135, 137),
      Color.fromARGB(255, 13, 97, 99),
      Color.fromARGB(255, 3, 61, 71),
    ],
    [
      Color.fromRGBO(148, 185, 227, 1),
      Color.fromRGBO(111, 149, 192, 1),
      Color.fromRGBO(84, 115, 151, 1),
    ]
  ];

  static const List<Color> backgroundAuth = [
    Color.fromRGBO(145, 131, 222, 1),
    Color.fromRGBO(160, 148, 227, 1),
  ];

  static const Color buttons = Color.fromRGBO(161, 133, 207, 1);
  static const Color darkerButtons = Color.fromARGB(255, 82, 67, 168);
  static const Color darkIcons = Color.fromARGB(255, 79, 66, 102);
  static const Color navigation = Color.fromRGBO(210, 202, 255, 1);
  static const Color field = Color.fromARGB(255, 255, 255, 255);
  static const Color background = Color.fromARGB(255, 247, 252, 255);
  static const Color blurryGradientColor = Colors.white;

  static Color fromColor(Color color,
      {int a = -1, int r = -1, int g = -1, int b = -1}) {
    return Color.fromARGB(a > -1 ? a : color.alpha, r > -1 ? r : color.red,
        g > -1 ? g : color.green, b > -1 ? b : color.blue);
  }
}
