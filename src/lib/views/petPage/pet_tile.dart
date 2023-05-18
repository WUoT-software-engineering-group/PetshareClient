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

  ImageProvider getImage(String photo) {
    if (photo == '') {
      return const AssetImage('assets/pupic.jpg');
    }

    ImageProvider image = const AssetImage('assets/pupic.jpg');
    // try {
    //   image = NetworkImage(photo);

    //   (image.resolve(ImageConfiguration())).addListener(ImageStreamListener(
    //     (image, synchronousCall) {
    //       print('obraz został załadowany');
    //     },
    //     onError: (exception, stackTrace) {
    //       print('cos poszło nie tak');
    //     },
    //   ));
    // } catch (e) {
    //   print('Wystapił błąd: $e');
    // }

    return image;
  }

  BoxDecoration imageDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: getImage(widget.pet!.photoUrl),
      ),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  BoxDecoration colorDecoration() {
    return BoxDecoration(
      color: widget.background,
      borderRadius: BorderRadius.circular(radius),
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
          child: Ink(
            height: widget.height,
            decoration:
                widget.pet != null ? imageDecoration() : colorDecoration(),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
