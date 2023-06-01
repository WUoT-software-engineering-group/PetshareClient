import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/authPage/animated_image.dart';

/// This page is shown as the first one in
/// this app. Here you can find loginup/in
/// button.
class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundAuth[0],
            AppColors.backgroundAuth[1],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Expanded(
              child: AnimatedImage(),
            ),
            Text(
              'Pet Share - We are for you',
              style: GoogleFonts.varelaRound(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: const [
                  Expanded(
                    child: Divider(
                      indent: 22,
                      thickness: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.pets,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      endIndent: 22,
                      thickness: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 300));
                BlocProvider.of<AppCubit>(context).authUser();
              },
              child: Text(
                'Sign in / Sign up',
                style: GoogleFonts.varelaRound(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
