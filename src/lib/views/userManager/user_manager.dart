import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_share/cubits/announcementsCubit/announcements_cubit.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/views/applicationPage/application_page.dart';
import 'package:pet_share/views/announcementPage/announcement_page.dart';
import 'package:pet_share/utils/app_colors.dart';

import '../formPage/form_page.dart';

class UserManager extends StatefulWidget {
  const UserManager({Key? key}) : super(key: key);

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = const [ApplicationPage(), AnnouncementPage(), FormPage()];
  int index = 1;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.drafts, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.pets, size: 30)
    ];

    return MultiBlocProvider(
        providers: [
          BlocProvider<AnnouncementsCubit>(
              create: (context) => AnnouncementsCubit(
                  announcements:
                      (BlocProvider.of<AppCubit>(context).state as AppSLoaded)
                          .announcements))
        ],
        child: Scaffold(
          backgroundColor: AppColors.background,

          // body body body
          body: screens[index],

          // navigation navigation
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: AppColors.navigation,
              buttonBackgroundColor: AppColors.buttons,
              backgroundColor: AppColors.background,
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
        ));
  }
}
