import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/utils/app_colors.dart';

class UsersPage extends StatelessWidget {
  final Color _mainColor = AppColors.animationColor['center']!;
  final Color _iconColor = AppColors.background;

  UsersPage({super.key});

  Widget _userButton(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 110, height: 110),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: _mainColor,
            foregroundColor: AppColors.navigation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: () {},
        child: Icon(iconData, size: 75, color: _iconColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your profile',
              style: GoogleFonts.varelaRound(
                  color: _mainColor, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _userButton(Icons.face),
              const SizedBox(
                width: 30,
              ),
              _userButton(Icons.pets),
            ]),
          ]),
    );
  }
}
