import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/loadingPage/gradient_text.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(145, 131, 222, 1),
            Color.fromRGBO(160, 148, 227, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            Lottie.asset(
              'assets/dogy.json',
              alignment: Alignment.bottomCenter,
            ),
            GradientText(text: 'Pet Share', colors: [
              (AppColors.animationColor['sides'])!,
              (AppColors.animationColor['center'])!,
              (AppColors.animationColor['sides'])!,
            ]),
          ],
        )),
      ),
    );
  }
}
