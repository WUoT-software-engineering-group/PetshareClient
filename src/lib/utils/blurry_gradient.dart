import 'package:flutter/material.dart';

class BlurryGradient extends StatelessWidget {
  final Color color;
  final List<double>? stops;
  final Widget child;

  const BlurryGradient(
      {super.key,
      required this.color,
      required this.stops,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color, color.withOpacity(0.0)],
          stops: stops,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
