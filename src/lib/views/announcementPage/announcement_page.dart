import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/blurry_gradient.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/announcement_tile.dart';

class AnnouncementPage extends StatefulWidget {
  final bool isAdoptingPerson;
  const AnnouncementPage({required this.isAdoptingPerson, Key? key})
      : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  // Future<void> _onRefresh() async {
  //   await
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.blurryGradientColor,
        stops: const [0.96, 1],
        child: LiquidPullToRefresh(
          showChildOpacityTransition: true,
          onRefresh: () async {
            await BlocProvider.of<AppCubit>(context).refreshAnnouncements();
          },
          springAnimationDurationInMilliseconds: 500,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state is AppSLoaded) {
                List<Announcement2> announcements = state.announcements;

                return AnimatedList(
                  initialItemCount: announcements.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index, animation) {
                    // add button - not supported at now
                    // if (index == 0) {
                    //   return AnimatedContainer(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 25, vertical: 12.5),
                    //     duration: const Duration(milliseconds: 300),
                    //     curve: Curves.easeIn,
                    //     child: Material(
                    //       color: AppColors.buttons,
                    //       borderRadius: BorderRadius.circular(28),
                    //       elevation: 6,
                    //       child: InkWell(
                    //         borderRadius: BorderRadius.circular(28),
                    //         onTap: () {},
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(28),
                    //           child: const SizedBox(
                    //             height: 50,
                    //             child: Icon(
                    //               Icons.add,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }

                    // announcement tiles
                    return AnnouncementTile(
                      announcement: announcements[index],
                      isAdoptingPerson: widget.isAdoptingPerson,
                      descriptionOnLeft: index % 2 == 0 ? true : false,
                      colors: AppColors
                          .petTiles[(index - 1) % AppColors.petTiles.length],
                      onPressed: () {
                        BlocProvider.of<AppCubit>(context)
                            .addApplication(announcements[index].id);
                      },
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
