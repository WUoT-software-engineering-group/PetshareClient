import 'dart:io';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'cubits/appCubit/app_cubit.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  if (Platform.isIOS) {
    await dotenv.load(fileName: 'envs/ios_config.env');
  } else if (Platform.isAndroid) {
    await dotenv.load(fileName: 'envs/android_config_api3.env');
  } else {
    throw Exception('This platform is not supported!');
  }

  HttpOverrides.global = MyHttpOverrides();
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
