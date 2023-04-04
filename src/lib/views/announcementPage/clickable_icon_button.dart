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
    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: Icon(
        Icons.favorite,
        size: 40,
        color: _isClicked ? widget.clicked : widget.nonClicked,
      ),
    );
  }
}
