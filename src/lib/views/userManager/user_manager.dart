import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_share/cubits/announcementsCubit/announcements_cubit.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/views/applicationPage/application_page.dart';
import 'package:pet_share/views/announcementPage/announcement_page.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/loginPage/users.dart';

import '../formPage/form_page.dart';

class UserManager extends StatefulWidget {
  const UserManager({Key? key}) : super(key: key);

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  late int _index;
  late PageController _controller;
  late List<Widget> _screens;
  late List<Widget> items;
  final _navigationKey = GlobalKey<CurvedNavigationBarState>();

  void _adoptingPersonSet() {
    _index = 0;

    _screens = const [
      AnnouncementPage(isAdoptingPerson: true),
    ];

    items = <Widget>[const Icon(Icons.home, size: 30)];
  }

  void _shelterSet() {
    _index = 1;

    _screens = const [
      ApplicationPage(),
      AnnouncementPage(isAdoptingPerson: false),
      FormPage()
    ];

    items = <Widget>[
      const Icon(Icons.drafts, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.pets, size: 30)
    ];
  }

  @override
  void initState() {
    UserType type =
        (BlocProvider.of<AppCubit>(context).state as AppSLoaded).type;

    if (type == UserType.adoptingPerson) {
      _adoptingPersonSet();
    } else {
      _shelterSet();
    }
    _controller = PageController(initialPage: _index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AnnouncementsCubit>(
              create: (context) => AnnouncementsCubit(
                  announcements:
                      (BlocProvider.of<AppCubit>(context).state as AppSLoaded)
                          .announcements))
        ],
        child: Scaffold(
          // body body body
          body: PageView(
            controller: _controller,
            children: _screens,
            onPageChanged: (value) {
              setState(() {
                _index = value;
              });
            },
          ),

          // navigation navigation
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
              key: _navigationKey,
              color: AppColors.navigation,
              buttonBackgroundColor: AppColors.buttons,
              backgroundColor: AppColors.background,
              height: 55,
              index: _index,
              items: items,
              onTap: (index) {
                setState(() {
                  _index = index;
                  _controller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                });
              },
            ),
          ),
        ));
  }
}
