import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/views/applicationPage/application_tile.dart';
import 'package:pet_share/utils/app_colors.dart';

import '../../utils/blurry_gradient.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  List<String> list = [
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
    'application1',
  ];

  Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.blurryGradientColor,
        stops: const [0.93, 1],
        child: LiquidPullToRefresh(
          springAnimationDurationInMilliseconds: 500,
          showChildOpacityTransition: true,
          onRefresh: _onRefresh,
          child: AnimatedList(
              physics: const BouncingScrollPhysics(),
              initialItemCount: list.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index, animation) {
                return const ApplicationTile();
              }),
        ),
      ),
    );
  }
}
