import 'package:flutter/material.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/userManager/user_manager.dart';

void main() {
  runApp(const MainPoint());
}

class MainPoint extends StatelessWidget {
  const MainPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch(accentColor: AppColors.buttons)),
        home: const UserManager());
  }
}
