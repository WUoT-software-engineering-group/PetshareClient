import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientText extends StatefulWidget {
  final String text;
  final List<Color> colors;
  const GradientText({super.key, required this.text, required this.colors});

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(stops: [
          _animation.value - 0.9,
          _animation.value,
          _animation.value + 0.9
        ], colors: widget.colors)
            .createShader(rect);
      },
      child: Text(
        widget.text,
        style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.white.withAlpha(180)),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
