import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/views/applicationPage/application_page.dart';
import 'package:pet_share/views/announcementPage/announcement_page.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/petPage/pet_page.dart';
import 'package:pet_share/views/userManager/nav_button.dart';
import 'package:provider/provider.dart';

class UserManager extends StatefulWidget {
  const UserManager({Key? key}) : super(key: key);

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  final _navigationKey = GlobalKey<CurvedNavigationBarState>();
  late PageController _controller;
  late List<Widget> _screens;
  late List<Widget> items;
  late int _index;
  late UserInfo _userInfo;

  // ---------------------------------------
  //  _UserManagerState methods
  // ---------------------------------------

  void _adoptingPersonSet() {
    _index = 0;

    _screens = const [
      AnnouncementPage(isAdoptingPerson: true),
    ];

    items = <Widget>[
      const NavButton(color: Colors.white, size: 35, iconData: Icons.home),
    ];
  }

  void _shelterSet() {
    _index = 1;

    _screens = const [
      ApplicationPage(),
      AnnouncementPage(isAdoptingPerson: false),
      PetPage(),
    ];

    items = <Widget>[
      const NavButton(color: Colors.white, size: 35, iconData: Icons.drafts),
      const NavButton(color: Colors.white, size: 35, iconData: Icons.home),
      const NavButton(color: Colors.white, size: 35, iconData: Icons.pets),
    ];
  }

  AppSLoaded asAppSLoaded() =>
      (BlocProvider.of<AppCubit>(context).state as AppSLoaded);

  // ---------------------------------------
  //  Init state
  // ---------------------------------------

  @override
  void initState() {
    _userInfo = asAppSLoaded().userInfo;
    UserRoles role = _userInfo.role;

    if (role == UserRoles.adopter) {
      _adoptingPersonSet();
    } else {
      _shelterSet();
    }

    _controller = PageController(initialPage: _index);
    super.initState();
  }

  // ---------------------------------------
  //  Building widget
  // ---------------------------------------

  @override
  Widget build(BuildContext context) {
    return Provider<UserInfo>(
      create: (_) => asAppSLoaded().userInfo,
      child: Scaffold(
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pet Share',
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppColors.buttons,
                ),
              ),
              Text(
                asAppSLoaded().userInfo.nickname,
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: AppColors.navigation,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                BlocProvider.of<AppCubit>(context).logoutUser();
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.buttons,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),

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
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Colors.white),
          ),
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
