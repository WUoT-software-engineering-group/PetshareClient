import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/blurry_gradient.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/announcement_filters.dart';
import 'package:pet_share/views/announcementPage/announcement_tile.dart';

class AnnouncementPage extends StatefulWidget {
  final bool isAdoptingPerson;
  const AnnouncementPage({required this.isAdoptingPerson, Key? key})
      : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final PagingController<int, Announcement2> _pagingController =
      PagingController(firstPageKey: 0);
  late FilterMe _filter;

  static const _pageSize = 7;

  @override
  void initState() {
    _filter = FilterMe();
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

    Map<String, String> filterQP = _filter.giveParameterQueries();
    filterQP.forEach((key, value) {
      qP[key] = value;
    });

    try {
      final newItems =
          await BlocProvider.of<AppCubit>(context).getAnnouncements(qP);

      if (newItems == null) {
        _pagingController.error = 'Problem with loading announcemnts';
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: BlurryGradient(
          color: AppColors.blurryGradientColor,
          stops: const [0.96, 1],
          child: Column(
            children: [
              SizedBox(
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const AnnouncementFilters();
                              }),
                            );

                            if (result != null && result is FilterMe) {
                              _filter = result;
                              Future.sync(
                                () => _pagingController.refresh(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 6,
                              padding: const EdgeInsets.all(0),
                              backgroundColor: AppColors.field,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                          child: const Icon(
                            Icons.sort,
                            color: AppColors.buttons,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(15),
                            child: TextField(
                              cursorColor:
                                  const Color.fromARGB(255, 117, 117, 117),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Search pet',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 212, 212, 212)),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color.fromARGB(255, 117, 117, 117),
                                ),
                                fillColor: AppColors.field,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: LiquidPullToRefresh(
                  showChildOpacityTransition: true,
                  onRefresh: () => Future.sync(
                    () => _pagingController.refresh(),
                  ),
                  springAnimationDurationInMilliseconds: 500,
                  child: BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      if (state is AppSLoaded) {
                        return PagedListView(
                          pagingController: _pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<Announcement2>(
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
                                    'No announcements found',
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
                              return AnnouncementTile(
                                announcement: item,
                                isAdoptingPerson: widget.isAdoptingPerson,
                                descriptionOnLeft:
                                    index % 2 == 0 ? true : false,
                                colors: AppColors.petTiles[
                                    (index - 1) % AppColors.petTiles.length],
                                onPressed: () {
                                  BlocProvider.of<AppCubit>(context)
                                      .addApplication(item.id);
                                },
                                addLike: (id, isLiked) {
                                  BlocProvider.of<AppCubit>(context)
                                      .putLikeAnnouncement(id, isLiked);
                                },
                              );
                            },
                          ),
                        );
                      }

                      return const Center();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
