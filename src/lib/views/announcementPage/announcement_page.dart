import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/cubits/announcementsCubit/announcements_cubit.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/utils/blurry_gradient.dart';
import 'package:pet_share/utils/filter.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/pet_tile.dart';
import 'package:provider/provider.dart';

class AnnouncementPage extends StatefulWidget {
  final bool isAdoptingPerson;
  const AnnouncementPage({required this.isAdoptingPerson, Key? key})
      : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  Future<void> _onRefresh() async {
    await BlocProvider.of<AnnouncementsCubit>(context).refresh(
      Provider.of<UserInfo>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.background,
        stops: const [0.96, 1],
        child: LiquidPullToRefresh(
          showChildOpacityTransition: true,
          onRefresh: _onRefresh,
          springAnimationDurationInMilliseconds: 500,
          child: BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
            builder: (context, state) {
              if (state is AnnouncementsSLoaded) {
                return AnimatedList(
                  physics: const BouncingScrollPhysics(),
                  initialItemCount: state.announcements.length + 1,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index, animation) {
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

                    return PetTile(
                      announcement: state.announcements[index - 1],
                      isAdoptingPerson: widget.isAdoptingPerson,
                      descriptionOnLeft: index % 2 == 0 ? true : false,
                      colors: AppColors
                          .petTiles[(index - 1) % AppColors.petTiles.length],
                    );
                  },
                );
              }

              return const Center();
            },
          ),
        ),
      ),
    );
  }
}
