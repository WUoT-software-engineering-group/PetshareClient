import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/utils/blurry_gradient.dart';
import 'package:pet_share/views/petPage/pet_tile.dart';

class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  Pet pp = Pet(
    id: '',
    shelterID: '',
    name: 'alo',
    species: 'asdf',
    breed: 'asdf',
    birthday: DateTime.now(),
    description: 'asdfadsf',
    photo: '',
  );

  late List<Pet> petsy;

  @override
  void initState() {
    super.initState();
    petsy = [
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
      pp,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.blurryGradientColor,
        stops: const [0.96, 1],
        child: MasonryGridView.count(
          itemCount: petsy.length,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          // the number of columns
          crossAxisCount: 3,
          // vertical gap between two items
          mainAxisSpacing: 10,
          // horizontal gap between two items
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            return PetTile(height: 100, pet: petsy[index]);
          },
        ),
      ),
    );
  }
}
