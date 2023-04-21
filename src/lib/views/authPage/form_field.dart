import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/utils/app_colors.dart';

class MyFormFild extends StatelessWidget {
  final String? Function(String?) validator;
  final Function(String?) save;
  final String label;

  const MyFormFild({
    super.key,
    required this.validator,
    required this.save,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: TextFormField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
            label: Text(
              label,
              style: GoogleFonts.varelaRound(
                color: AppColors.darkerButtons,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(25),
            )),
        style: GoogleFonts.varelaRound(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        validator: validator,
        onSaved: save,
      ),
    );
  }
}
