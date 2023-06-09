import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/utils/app_colors.dart';

class ApplicationDialog extends StatelessWidget {
  final Appplications2 appplication;
  final Future<void> Function() acceptFun;
  final Future<void> Function() rejectFun;

  final String myText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar nunc iaculis '
      'mi condimentum dictum. Proin vel dui et tortor vehicula placerat. Interdum et malesuada '
      'fames ac ante ipsum primis in faucibus. Nullam non bibendum massa. Fusce elementum '
      'enim magna, eu malesuada quam mollis in.';

  const ApplicationDialog({
    required this.appplication,
    required this.acceptFun,
    required this.rejectFun,
    Key? key,
  }) : super(key: key);

  Widget getImage() {
    if (appplication.announcement.pet.photoUrl == '' ||
        appplication.announcement.pet.photoUrl.contains('https')) {
      return Image.asset('assets/pupic.jpg', fit: BoxFit.cover);
    }

    return Image.network(
      appplication.announcement.pet.photoUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/pupic.jpg', fit: BoxFit.cover);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        backgroundColor: AppColors.field,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 12.5, 25, 12.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.darkIcons,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/kity_blur.jpg'),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 30,
                endIndent: 25,
                indent: 25,
                color: AppColors.darkIcons,
              ),
              Text(
                appplication.adopter.userName,
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(myText),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      await acceptFun();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          color: AppColors.darkIcons,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ACCEPT',
                          style: GoogleFonts.varelaRound(
                            color: AppColors.darkerButtons,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () async {
                      await rejectFun();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: AppColors.darkIcons,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'REJECT',
                          style: GoogleFonts.varelaRound(
                            color: AppColors.darkerButtons,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
