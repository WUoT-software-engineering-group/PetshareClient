import 'package:flutter/material.dart';

class ClickableIconButton extends StatefulWidget {
  final Color nonClicked;
  final Color clicked;
  const ClickableIconButton(
      {required this.nonClicked, required this.clicked, super.key});

  @override
  State<ClickableIconButton> createState() => _ClickableIconButtonState();
}

class _ClickableIconButtonState extends State<ClickableIconButton> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    final Widget iconNotClicked =
        Icon(Icons.favorite_border, size: 30, color: widget.nonClicked);

    final Widget iconClicked =
        Icon(Icons.favorite, size: 30, color: widget.clicked);

    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: _isClicked ? iconClicked : iconNotClicked,
    );
  }
}
