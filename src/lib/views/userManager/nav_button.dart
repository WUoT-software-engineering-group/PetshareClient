import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  final IconData iconData;
  final double size;
  final Color color;

  const NavButton({
    required this.color,
    required this.size,
    required this.iconData,
    super.key,
  });

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => setState(() => isPressed = true),
      onPointerUp: (_) => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: Icon(
          widget.iconData,
          size: isPressed ? widget.size - 8 : widget.size,
          color: isPressed ? widget.color.withOpacity(0.7) : widget.color,
        ),
      ),
    );
  }
}
