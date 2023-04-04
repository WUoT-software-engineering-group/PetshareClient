import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/utils/filter.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/pet_tile.dart';

import '../../cubits/announcementsCubit/announcements_cubit.dart';
import '../../utils/blurry_gradient.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  Future<void> _onRefresh() async {
    await BlocProvider.of<AnnouncementsCubit>(context).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlurryGradient(
          color: AppColors.background,
          stops: const [0.96, 1],
          child: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            onRefresh: _onRefresh,
            child: BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
              builder: (context, state) {
                if (state is AnnouncementsSLoaded) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: state.announcements.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const OurFilter([
                          'dog',
                          'fast',
                          'fat',
                          'young',
                          'mid',
                          'old',
                          'beautiful',
                          'ugly',
                          'slow',
                          'sweet',
                          'only puppies',
                        ]);
                      }

                      return PetTile(state.announcements[index - 1]);
                    },
                  );
                }

                return const Center();
              },
            ),
          ),
        ),
      ),
    );
  }
}
