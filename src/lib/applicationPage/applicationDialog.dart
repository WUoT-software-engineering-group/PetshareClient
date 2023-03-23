import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_io2/utils/ourColors.dart';

class ApplicationDialog extends StatelessWidget {
  final String myText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar nunc iaculis '
      'mi condimentum dictum. Proin vel dui et tortor vehicula placerat. Interdum et malesuada '
      'fames ac ante ipsum primis in faucibus. Nullam non bibendum massa. Fusce elementum '
      'enim magna, eu malesuada quam mollis in.';

  const ApplicationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 12.5, 25, 12.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 40,
                backgroundColor: DDarkHoneydew,
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
                color: DDarkHoneydew,
              ),
              const Text(
                'Joanna Eule',
                style: TextStyle(
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Column(children: const [
                      Icon(
                        Icons.thumb_up,
                        color: DDarkHoneydew,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ACCEPT',
                        style: TextStyle(color: DDarkHoneydew),
                      )
                    ]),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Column(children: const [
                      Icon(
                        Icons.delete,
                        color: DDarkHoneydew,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'DELETE',
                        style: TextStyle(color: DDarkHoneydew),
                      )
                    ]),
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
