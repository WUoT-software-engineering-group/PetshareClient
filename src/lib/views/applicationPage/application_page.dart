import 'package:flutter/material.dart';
import 'package:pet_share/views/applicationPage/application_tile.dart';
import 'package:pet_share/utils/filter.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlurryGradient(
          color: AppColors.background,
          stops: const [0.93, 1],
          child: ListView.builder(
            itemCount: list.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const OurFilter([
                  'dog',
                  'fast',
                  'fat',
                  'young',
                  'mid',
                  'old',
                  'beautiful',
                  'ugly',
                  'slow',
                  'sweet',
                  'only puppies',
                ]);
              }

              return const ApplicationTile();
            },
          ),
        ),
      ),
    );
  }
}
