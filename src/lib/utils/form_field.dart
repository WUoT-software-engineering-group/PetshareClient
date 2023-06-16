import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/utils/app_colors.dart';

class MyFormFild2 extends StatelessWidget {
  final String? Function(String?) validator;
  final Function(String?) save;
  final String label;
  final Color labelColor;
  final Color activeBorder;
  final Color disactiveBorder;
  final Color fontColor;
  final int maxLines;
  final String? initialValue;
  final Widget? suffixIcon;

  const MyFormFild2({
    super.key,
    required this.validator,
    required this.save,
    required this.label,
    this.labelColor = AppColors.darkerButtons,
    this.activeBorder = Colors.white,
    this.disactiveBorder = Colors.white,
    this.fontColor = Colors.white,
    this.maxLines = 1,
    this.initialValue,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          label: Text(
            label,
            style: GoogleFonts.varelaRound(
              color: labelColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: activeBorder,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: disactiveBorder,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        style: GoogleFonts.varelaRound(
          color: fontColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        validator: validator,
        onSaved: save,
      ),
    );
  }
}
