import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  static const _pageSize = 9;

  final PagingController<int, Pet2> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener(
      (pageKey) => _fetchPage(pageKey),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    int pp = pageKey ~/ _pageSize;
    Map<String, String> qP = {
      'pageNumber': pp.toString(),
      'pageCount': _pageSize.toString()
    };

    try {
      final newItems = await BlocProvider.of<AppCubit>(context).getPets(qP);

      if (newItems == null) {
        _pagingController.error = 'Problem with loading pets';
        return;
      }

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryGradient(
        color: AppColors.blurryGradientColor,
        stops: const [0.96, 1],
        child: LiquidPullToRefresh(
          showChildOpacityTransition: true,
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          springAnimationDurationInMilliseconds: 500,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state is AppSLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8, top: 4, left: 25, right: 25),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttons,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PagedGridView(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          pagingController: _pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Pet2>(
                            noItemsFoundIndicatorBuilder: (context) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/empty_box.png',
                                    width: 180,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const Text(
                                    'No pets found',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.buttons,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 190,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: AppColors.buttons,
                                        backgroundColor: AppColors.navigation,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await Future.delayed(
                                            const Duration(milliseconds: 350));
                                        await Future.sync(
                                          () => _pagingController.refresh(),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.refresh,
                                            color: AppColors.background,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'Try Again',
                                            style: TextStyle(
                                              color: AppColors.background,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            itemBuilder: (context, item, index) {
                              return PetTile(
                                height: 100,
                                pet: item,
                                tapOn: () async {
                                  var result = await showDialog(
                                    context: context,
                                    builder: (context) => PetDialog(
                                      pet: item,
                                    ),
                                  );

                                  if (context.mounted &&
                                      result is bool &&
                                      result) {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AnnouncementForm(
                                          pet: item,
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
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          )),
                    )
                  ],
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
