import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  final PagingController<int, Appplications2> _pagingController =
      PagingController(firstPageKey: 0);

  static const _pageSize = 5;

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
      final newItems =
          await BlocProvider.of<AppCubit>(context).getApplications(qP);

      if (newItems == null) {
        _pagingController.error = 'Problem with loading applicatons';
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
        stops: const [0.93, 1],
        child: LiquidPullToRefresh(
          springAnimationDurationInMilliseconds: 500,
          showChildOpacityTransition: true,
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state is AppSLoaded) {
                return PagedListView(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Appplications2>(
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
                            'No applications found',
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
                                  borderRadius: BorderRadius.circular(15),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                      return ApplicationTile(
                        appplications: item,
                        rejectFun: () async {
                          await BlocProvider.of<AppCubit>(context)
                              .rejectApplication(item.id);
                        },
                        acceptFun: () async {
                          await BlocProvider.of<AppCubit>(context)
                              .acceptApplication(item.id);
                        },
                      );
                    },
                  ),
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
