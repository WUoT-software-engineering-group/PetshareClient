import 'package:flutter/material.dart';

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({super.key});

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0.09),
  ).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset('assets/flying_cat_clouds.png'),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SlideTransition(
              position: _animation,
              child: Image.asset('assets/flying_cat_only.png'),
            ),
          ),
        ),
      ],
    );
  }
}
