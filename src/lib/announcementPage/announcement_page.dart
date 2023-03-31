import 'package:flutter/material.dart';
import 'package:pet_share/utils/filter.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/announcementPage/pet_tile.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List<String> elements = [
    'dog 1',
    'dog 2',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 3',
    'dog 4'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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

            // list of Tiles with announcements
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background,
                      AppColors.background.withOpacity(0.0)
                    ],
                    stops: const [0.97, 1],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: elements.length,
                  itemBuilder: (context, index) {
                    return PetTile(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
