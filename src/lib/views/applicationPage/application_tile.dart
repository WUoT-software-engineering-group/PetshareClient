import 'package:flutter/material.dart';
import 'package:pet_share/views/applicationPage/application_dialog.dart';
import 'package:pet_share/utils/app_colors.dart';

class ApplicationTile extends StatefulWidget {
  const ApplicationTile({Key? key}) : super(key: key);

  @override
  State<ApplicationTile> createState() => _ApplicationTileState();
}

class _ApplicationTileState extends State<ApplicationTile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(25, 12.5, 25, 12.5),
      child: Material(
        color: AppColors.field,
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => const ApplicationDialog());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Row(
              children: [
                SizedBox(width: 70, child: Image.asset('assets/kity_blur.jpg')),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Icon(
                            Icons.perm_identity,
                            color: AppColors.smallElements['reddish'],
                            size: 17,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text(
                            ':  Joanna Eule',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                      Text(
                        '13 marca 2022 15:00',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.mail_outline,
                  color: AppColors.smallElements['reddish'],
                ),
                const SizedBox(
                  width: 12.5,
                ),
                const Text('41'),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
