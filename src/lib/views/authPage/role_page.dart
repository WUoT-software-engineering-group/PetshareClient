import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/shelter.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/authPage/auth_pages_router.dart';
import 'package:pet_share/views/authPage/forms_page.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  final Color _mainColor = Colors.white;
  final Color _iconColor = const Color.fromRGBO(145, 131, 222, 1);

  Widget _userButton(IconData iconData, Function()? presse) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        width: 110,
        height: 110,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: _mainColor,
            foregroundColor: const Color.fromARGB(255, 210, 203, 248),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: presse,
        child: Icon(
          iconData,
          size: 75,
          color: _iconColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundAuth[0],
            AppColors.backgroundAuth[1],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocProvider(
          create: (context) => BlocProvider.of<AppCubit>(context),
          child: SafeArea(
            // Main Page
            // ---------
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose your profile',
                  style: GoogleFonts.varelaRound(
                    color: _mainColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _userButton(
                      // ADOPTER BUTTON
                      Icons.face,
                      () async {
                        // This function is one of most important. It is
                        // responsible for coming back from FORMS
                        var adopter = await Navigator.of(context).push(
                          AuthPagesRouter.createRoute(
                            AdopterForm(
                              email:
                                  BlocProvider.of<AppCubit>(context).getEmail,
                            ),
                          ),
                        );

                        if (context.mounted && adopter is CreatingAdopter) {
                          await BlocProvider.of<AppCubit>(context)
                              .setAddopter(adopter);
                        }
                      },
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    _userButton(
                      // ADOPTER BUTTON
                      Icons.pets,
                      () async {
                        // This function is one of most important. It is
                        // responsible for coming back from FORMS
                        var shelter = await Navigator.of(context).push(
                          AuthPagesRouter.createRoute(
                            fromLeft: false,
                            ShelterForm(
                              email:
                                  BlocProvider.of<AppCubit>(context).getEmail,
                            ),
                          ),
                        );

                        if (context.mounted && shelter is CreatingShelter) {
                          await BlocProvider.of<AppCubit>(context)
                              .setShelter(shelter);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 3),
                        foregroundColor: AppColors.navigation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () async {
                      BlocProvider.of<AppCubit>(context).logoutUser();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'log out',
                          style: GoogleFonts.varelaRound(
                            color: _mainColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
