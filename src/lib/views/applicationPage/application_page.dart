import 'package:flutter/material.dart';
import 'package:pet_share/views/applicationPage/application_tile.dart';
import 'package:pet_share/utils/filter.dart';
import 'package:pet_share/utils/app_colors.dart';

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
        child: Column(children: [
          const OurFilter([
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
          ]),
          const SizedBox(height: 10),
          Flexible(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background,
                    AppColors.background.withOpacity(0.0)
                  ],
                  stops: const [0.93, 1],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return const ApplicationTile();
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
