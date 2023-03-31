import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_share/applicationPage/application_page.dart';
import 'package:pet_share/announcementPage/announcement_page.dart';
import 'package:pet_share/utils/app_colors.dart';

import '../formPage/form_page.dart';

class UserManager extends StatefulWidget {
  const UserManager({Key? key}) : super(key: key);

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 1;

  final screens = const [ApplicationPage(), AnnouncementPage(), FormPage()];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.drafts, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.pets, size: 30)
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: AppColors.navigation,
          buttonBackgroundColor: AppColors.buttons,
          backgroundColor: Colors.transparent,
          height: 55,
          index: index,
          items: items,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
      ),
    );
  }
}
