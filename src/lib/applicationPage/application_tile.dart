import 'package:flutter/material.dart';
import 'package:test_io2/applicationPage/application_dialog.dart';
import 'package:test_io2/utils/our_colors.dart';

class ApplicationTile extends StatefulWidget {
  const ApplicationTile({Key? key}) : super(key: key);

  @override
  State<ApplicationTile> createState() => _ApplicationTileState();
}

class _ApplicationTileState extends State<ApplicationTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 12.5, 25, 12.5),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const ApplicationDialog());
        },
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                      width: 70, child: Image.asset('assets/kity_blur.jpg')),
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
                          child: Row(children: const [
                            Icon(
                              Icons.perm_identity,
                              color: dDarkHoneydew,
                              size: 17,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
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
                  const Icon(
                    Icons.mail_outline,
                    color: dDarkHoneydew,
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
      ),
    );
  }
}
