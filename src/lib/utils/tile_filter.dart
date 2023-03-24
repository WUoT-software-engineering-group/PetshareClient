import 'package:flutter/material.dart';
import 'package:test_io2/utils/our_colors.dart';

class TileFilter extends StatelessWidget {
  final String text;

  const TileFilter(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.5, right: 2.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(12.5),
          color: rose,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200]),
            ),
          ),
        ),
      ),
    );
  }
}
