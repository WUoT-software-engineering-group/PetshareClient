import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';

class PetDialog extends StatelessWidget {
  final Pet2 pet;

  const PetDialog({
    required this.pet,
    super.key,
  });

  IconData _iconOfSex(SexOfPet sex) {
    switch (sex) {
      case SexOfPet.unknown:
        return Icons.question_mark;

      case SexOfPet.male:
        return Icons.male;

      case SexOfPet.female:
        return Icons.female;

      case SexOfPet.doesNotApply:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        backgroundColor: AppColors.field,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 12.5, 25, 12.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    pet.photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/pupic.jpg', fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _iconOfSex(pet.sex),
                    color: const Color.fromARGB(221, 49, 49, 49),
                  ),
                  Text(
                    ' : ${pet.name}',
                    style: GoogleFonts.varelaRound(
                      fontSize: 16,
                      color: const Color.fromARGB(221, 49, 49, 49),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        'Species : ',
                        style: GoogleFonts.varelaRound(
                          color: const Color.fromARGB(221, 77, 77, 77),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        pet.species,
                        style: GoogleFonts.varelaRound(
                          color: const Color.fromARGB(221, 49, 49, 49),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Breed : ',
                        style: GoogleFonts.varelaRound(
                          color: const Color.fromARGB(221, 77, 77, 77),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        pet.breed,
                        style: GoogleFonts.varelaRound(
                          color: const Color.fromARGB(221, 49, 49, 49),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text('DESCRIPTION : ${pet.description}'),
                    ),
                  )
                ],
              ),

              // Make announcement button
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttons,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: Text(
                  'Add announcement',
                  style: GoogleFonts.varelaRound(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
