import 'package:bouncing_button/bouncing_button.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_home_page/home_page_bloc.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_presentation/common/app_carousel.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/screen_home_page/widgets/item_system_ad.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'widgets/item_trending_game.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pageViewController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  void initState() {
    context.read<HomePageBloc>().add(const LoadHomePageEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoading) {
            return const AppLoadingWidget();
          }
          if (state is HomePageLoadingError) {
            return AppErrorWidget(
              onTryAgain: () {
                context.read<HomePageBloc>().add(const LoadHomePageEvent());
              },
            );
          }

          if (state is HomePageLoaded) {
            return buildLoadedView(context, state.homePageData);
          }

          return const SizedBox();
        },
      ),
    );
  }

  SingleChildScrollView buildLoadedView(
      BuildContext context, HomePageData homePageData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///BUILD HEADER CARDS
          buildHeaderCards(homePageData),

          ///BUILD CATEGORIES LIST
          buildCategoriesList(context, homePageData.categoryList),

          ///BUILD TRENDING
          buildTrendingItems(context,homePageData),
        ],
      ),
    );
  }

  Column buildTrendingItems(BuildContext context, HomePageData homePageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_3,
          ),
          child: Text(
            "Trending",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        SizedBox(
          height: AppSizes.mp_v_2,
        ),
        ExpandablePageView.builder(
          itemCount: homePageData.trendingCategories.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          controller: _pageViewController,
          itemBuilder: (context, index) {
            var scale = _currentIndex == index ? 1.0 : 0.9;
            return TweenAnimationBuilder(
              tween: Tween(begin: scale, end: scale),
              duration: const Duration(milliseconds: 350),
              builder: (BuildContext context, Object value, Widget? child) {
                return Transform.scale(
                  scale: (value as double),
                  child: child,
                );
              },
              child: ItemTrendingGame(
                onPlay: () {
                  Navigator.pushNamed(
                    context,
                    AppRouterPaths.gamePlayerInfoPage,
                    arguments: ScreenArguments(
                      data: {
                        'categoryId': homePageData.trendingCategories.elementAt(index).categoryId,
                      },
                    ),
                  );
                }, categoryTrending: homePageData.trendingCategories.elementAt(index),
              ),
            );
          },
        ),
        SizedBox(
          height: AppSizes.mp_v_2,
        ),
      ],
    );
  }

  buildCategoriesList(BuildContext context, List<Category> categoryList) {
    return Container(
      margin: EdgeInsets.only(
        bottom: AppSizes.mp_v_4,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey,
                        fontSize: AppSizes.font_12,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                BouncingButton(
                  child: Text(
                    "View All",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.gold,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouterPaths.allCategoriesPage,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buildCategrisList(categoryList),
            ),
          )
        ],
      ),
    );
  }

  buildHeaderCards(HomePageData homePageData) {
    return Container(
      margin: EdgeInsets.only(
        top: AppSizes.mp_w_1,
        bottom: AppSizes.mp_v_2,
        // left: AppSizes.mp_w_3,
        //right: AppSizes.mp_w_3,
      ),
      child: AppCarousel(
          dotColor: AppColors.lightWhite,
          selectedDotColor: AppColors.gold,
          children: homePageData.ads
              .map((e) => ItemSystemAd(
            height: AppSizes.icon_size_32*1.2,
                    onTap: () {},
                    ad: e,
                  ))
              .toList()),
    );
  }

  buildCategrisList(List<Category> categoryList) {
    List<Widget> categoriesList = [];

    categoriesList = List.generate(
      categoryList.length,
      (index) => Container(
        margin: EdgeInsets.only(
          right: AppSizes.mp_w_1,
          left: AppSizes.mp_w_3,
          top: AppSizes.mp_v_1,
          bottom: AppSizes.mp_v_1,
        ),
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(AppSizes.radius_6),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: AppButtonFeedBack(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouterPaths.gamePlayerInfoPage,
              arguments: ScreenArguments(
                data: {
                  'categoryId': categoryList.elementAt(index).id,
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_6,
              vertical: AppSizes.mp_v_2,
            ),
            child: Row(
              children: [
                Icon(
                  faIconNameMapping[categoryList.elementAt(index).icon.name],
                  size: AppSizes.icon_size_4,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: AppSizes.mp_w_2,
                ),
                Text(
                  categoryList.elementAt(index).name.nameAm,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return categoriesList;
  }
}
