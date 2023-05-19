import 'package:flutter/material.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';

class PetTile extends StatefulWidget {
  final Pet2? pet;
  final double height;

  final Color? background;
  final Icon? icon;

  final void Function() tapOn;

  const PetTile({
    required this.tapOn,
    required this.height,
    this.pet,
    this.background,
    this.icon,
    super.key,
  });

  @override
  State<PetTile> createState() => _PetTileState();
}

class _PetTileState extends State<PetTile> {
  final double radius = 10;
  bool isPressed = false;

  Widget coloredInk() {
    return Ink(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: widget.icon,
    );
  }

  Widget imageInk() {
    if (widget.pet!.photoUrl == '' || !widget.pet!.photoUrl.contains('https')) {
      return Ink(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.asset('assets/pupic.jpg', fit: BoxFit.cover),
        ),
      );
    }

    return Ink(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          widget.pet!.photoUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/pupic.jpg', fit: BoxFit.cover);
          },
        ),
      ),
    );
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
          onTap: widget.tapOn,
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
          child: widget.pet != null ? imageInk() : coloredInk(),
        ),
      ),
    );
  }
}
