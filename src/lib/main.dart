import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/services/data_services.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/authPage/hello_page.dart';
import 'package:pet_share/views/authPage/role_page.dart';
import 'package:pet_share/views/loadingPage/loading_page.dart';
import 'package:pet_share/views/userManager/user_manager.dart';

import 'cubits/appCubit/app_cubit.dart';

void main() {
  runApp(const MainPoint());
}

class MainPoint extends StatelessWidget {
  const MainPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.buttons),
        textTheme:
            GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.navigation,
          contentTextStyle: GoogleFonts.varelaRound(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 6,
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: BlocProvider<AppCubit>(
        create: (context) => AppCubit(
          DataServices2(),
          AuthService(),
          reaction: (message) {
            var snackBar = SnackBar(
              content: Text(
                message,
              ),
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state is AppSLoaded || state is AppSRefreshing) {
              return const UserManager();
            } else if (state is AppSLoading) {
              return const LoadingPage();
            } else if (state is AppSAuthed) {
              return const RolePage();
            } else {
              return const HelloPage();
            }
          },
        ),
      ),
    );
  }
}
