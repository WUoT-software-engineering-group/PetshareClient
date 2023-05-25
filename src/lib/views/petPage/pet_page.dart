import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/utils/blurry_gradient.dart';
import 'package:pet_share/views/announcementPage/announcement_form.dart';
import 'package:pet_share/views/petPage/pet_dialog.dart';
import 'package:pet_share/views/petPage/pet_form.dart';
import 'package:pet_share/views/petPage/pet_tile.dart';

class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.blurryGradientColor,
        stops: const [0.96, 1],
        child: LiquidPullToRefresh(
          showChildOpacityTransition: true,
          onRefresh: () async {
            await BlocProvider.of<AppCubit>(context).refreshPets();
          },
          springAnimationDurationInMilliseconds: 500,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state is AppSLoaded) {
                List<Pet2> petsy = state.pets;

                return MasonryGridView.count(
                  itemCount: petsy.length + 1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  // the number of columns
                  crossAxisCount: 3,
                  // vertical gap between two items
                  mainAxisSpacing: 10,
                  // horizontal gap between two items
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    // add button
                    if (index == 0) {
                      return PetTile(
                        height: 100,
                        tapOn: () async {
                          var pet = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PetFrom(),
                            ),
                          );

                          if (context.mounted && pet is CreatingPet2) {
                            await BlocProvider.of<AppCubit>(context)
                                .addPet(pet);
                          }
                        },
                        background: AppColors.buttons,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 55,
                        ),
                      );
                    }

                    // pet tiles
                    return PetTile(
                      height: 100,
                      pet: petsy[index - 1],
                      tapOn: () async {
                        var result = await showDialog(
                          context: context,
                          builder: (context) => PetDialog(
                            pet: petsy[index - 1],
                          ),
                        );

                        if (context.mounted && result is bool && result) {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnnouncementForm(
                                pet: petsy[index - 1],
                              ),
                            ),
                          );

                          if (context.mounted &&
                              result is CreatingAnnouncement2) {
                            await BlocProvider.of<AppCubit>(context)
                                .addAnnouncement(result);
                          }
                        }
                      },
                    );
                  },
                );
              }

              return Center(
                child: Text(
                  'Loading ...',
                  style: GoogleFonts.varelaRound(
                    color: AppColors.buttons,
                    fontSize: 25,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
