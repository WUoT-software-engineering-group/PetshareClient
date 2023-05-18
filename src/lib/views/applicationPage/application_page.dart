import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/views/applicationPage/application_tile.dart';
import 'package:pet_share/utils/app_colors.dart';

import '../../utils/blurry_gradient.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.blurryGradientColor,
        stops: const [0.93, 1],
        child: LiquidPullToRefresh(
          springAnimationDurationInMilliseconds: 500,
          showChildOpacityTransition: true,
          onRefresh: () async {
            await BlocProvider.of<AppCubit>(context).refreshApplications();
          },
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state is AppSLoaded) {
                List<Appplications2> applications = state.applications;

                // application tiles
                return AnimatedList(
                    initialItemCount: applications.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index, animation) {
                      return ApplicationTile(
                        appplications: applications[index],
                      );
                    });
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
