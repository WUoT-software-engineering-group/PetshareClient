import 'package:flutter/material.dart';
import 'package:pet_share/utils/filter.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/pet_tile.dart';

import '../../utils/blurry_gradient.dart';

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
        child: BlurryGradient(
          color: AppColors.background,
          stops: const [0.96, 1],
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: elements.length + 1,
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

              return PetTile(index - 1);
            },
          ),
        ),
      ),
    );
  }
}
