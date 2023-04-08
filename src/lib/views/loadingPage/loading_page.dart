import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/loadingPage/gradient_text.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
