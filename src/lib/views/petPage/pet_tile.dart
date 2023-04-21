import 'package:flutter/material.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';

class PetTile extends StatefulWidget {
  final Pet pet;
  final double height;

  const PetTile({
    required this.height,
    required this.pet,
    super.key,
  });

  @override
  State<PetTile> createState() => _PetTileState();
}

class _PetTileState extends State<PetTile> {
  final double radius = 10;
  bool isPressed = false;

  ImageProvider getImage(String photo) {
    if (photo == '') {
      return const AssetImage('assets/pupic.jpg');
    }

    return NetworkImage(photo);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: isPressed ? 1.1 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        elevation: 6,
        child: InkWell(
          splashColor: AppColors.background.withOpacity(0.05),
          onTap: () {},
          onTapDown: (_) {
            setState(() {
              isPressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isPressed = false;
            });
          },
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            height: widget.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: getImage(widget.pet.photo),
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
    );
  }
}
