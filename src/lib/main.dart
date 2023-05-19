import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          fontFamily: 'varelaRound',
        ),
        home: BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
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
        ));
  }
}
