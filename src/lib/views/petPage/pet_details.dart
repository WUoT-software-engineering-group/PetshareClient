import 'package:flutter/material.dart';
import 'package:pet_share/utils/app_colors.dart';

class PetDatails extends StatefulWidget {
  const PetDatails({super.key});

  @override
  State<PetDatails> createState() => _PetDatailsState();
}

class _PetDatailsState extends State<PetDatails> {
  @override
  Widget build(BuildContext context) {
    const int firstPart = 6;
    const int secondPart = 5;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: firstPart,
                  child: Image.asset(
                    'assets/pupic.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: secondPart,
                  child: Container(
                    color: AppColors.background,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Go Back'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: firstPart * height / (firstPart + secondPart) - 60,
            left: 25,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.field,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: width - 50,
                height: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
