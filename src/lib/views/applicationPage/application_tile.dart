import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/views/applicationPage/application_dialog.dart';
import 'package:pet_share/utils/app_colors.dart';

class ApplicationTile extends StatefulWidget {
  final Appplications2 appplications;

  const ApplicationTile({
    required this.appplications,
    Key? key,
  }) : super(key: key);

  @override
  State<ApplicationTile> createState() => _ApplicationTileState();
}

class _ApplicationTileState extends State<ApplicationTile> {
  String _convertDateTime(DateTime? dateTime) {
    if (dateTime == null) return "";

    return DateFormat('d MMM y H:m').format(dateTime);
  }

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
              builder: (BuildContext context) => ApplicationDialog(
                appplication: widget.appplications,
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Image.asset('assets/kity_blur.jpg'),
                ),
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
                        child: Row(
                          children: [
                            const Icon(
                              Icons.perm_identity,
                              color: AppColors.darkIcons,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              ':  ${widget.appplications.adopter.userName}',
                              style: GoogleFonts.varelaRound(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _convertDateTime(widget.appplications.creationDate),
                        style: GoogleFonts.varelaRound(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mail_outline,
                        size: 27,
                        color: AppColors.darkIcons,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '41',
                        style: GoogleFonts.varelaRound(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkIcons,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
