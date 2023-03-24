import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:test_io2/applicationPage/application_page.dart';
import 'package:test_io2/announcementPage/announcement_page.dart';
import 'package:test_io2/utils/our_colors.dart';

import '../formPage/form_page.dart';

class PageManager extends StatefulWidget {
  const PageManager({Key? key}) : super(key: key);

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
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
      backgroundColor: basicScaffoldColor,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: rose,
          buttonBackgroundColor: mountbatten,
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
