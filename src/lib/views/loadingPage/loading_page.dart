import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/loadingPage/gradient_text.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Lottie.asset(
              'assets/dogy.json',
              alignment: Alignment.bottomCenter,
            ),
          ),
          Expanded(
            flex: 2,
            child: GradientText(text: 'Pet Share', colors: [
              (AppColors.animationColor['sides'])!,
              (AppColors.animationColor['center'])!,
              (AppColors.animationColor['sides'])!,
            ]),
          )
        ],
      )),
    );
  }
}
