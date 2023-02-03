import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_presentation/screen_public_page/widgets/bottom_sheet_filter_challanges.dart';
import 'package:quiz_bet/layer_presentation/screen_public_page/widgets/dialog_sort_challanges.dart';
import 'package:quiz_bet/layer_presentation/screen_public_page/widgets/item_search_result.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class PublicPage extends StatefulWidget {
  const PublicPage({Key? key}) : super(key: key);

  @override
  State<PublicPage> createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  final TextEditingController textEditingController = TextEditingController();

  final List<String> selectedFilters = [
    "2hr- 7hr",
    "Sport",
    "Physics",
    "Chemistry",
    "Books",
    "2hr- 7hr",
    "Sport",
    "English",
    "Chemistry",
    "Books",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            ///BUILD PAGE HEADER SEARCH AND FILTER
            buildPageHeaderSearchAndFilter(context),

            SizedBox(
              height: AppSizes.mp_v_2,
            ),

            ///BUILD SELECTED FILTER LIST
            buildSelectedFilterList(),

            SizedBox(
              height: AppSizes.mp_v_1,
            ),

            ///BUILD SEARCH RESULT
            buildBuildSearchResult(),
          ],
        ),
        floatingActionButton: buildFloatingActionButton(),
      ),
    );
  }

  Expanded buildBuildSearchResult() {
    return Expanded(
      child: ListView.separated(
        itemCount: 15,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.mp_w_3,
          vertical: AppSizes.mp_v_2,
        ),
        itemBuilder: (context, index) {
          return const ItemSearchResult();
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppSizes.mp_v_2,
              right: AppSizes.mp_v_1,
              top: AppSizes.mp_v_1 / 2,
              bottom: AppSizes.mp_v_1 / 2,
            ),
            child: Divider(
              color: AppColors.lightGrey,
            ),
          );
        },
      ),
    );
  }

  SizedBox buildSelectedFilterList() {
    return SizedBox(
      height: 8.h,
      child: MasonryGridView.count(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_3),
        itemCount: selectedFilters.length,
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.mp_w_1,
        mainAxisSpacing: AppSizes.mp_w_1,
        itemBuilder: (context, index) {
          return buildSelectedFilteringItems(
            selectedFilters.elementAt(index),
          );
        },
      ),
    );
  }

  buildPageHeaderSearchAndFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_3),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radius_6),
                color: AppColors.lightWhite,
              ),
              child: TextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.mp_w_4,
                    vertical: AppSizes.mp_v_1,
                  ),
                  hintText: "Search for groups",
                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkGrey,
                        fontSize: AppSizes.font_10,
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.radius_6,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: AppColors.lightWhite,
                  suffixIcon: Icon(
                    FontAwesomeIcons.lightMagnifyingGlass,
                    size: AppSizes.icon_size_6 * 0.8,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_2,
          ),
          BouncingButton(
            child: Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.mp_w_4 * 0.95),
                child: Icon(
                  FontAwesomeIcons.lightFilterList,
                  color: AppColors.darkBlue,
                  size: AppSizes.icon_size_6 * 0.7,
                ),
              ),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: AppColors.transparent,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return BottomSheetFilterChallenges();
                },
              );
            },
          ),
          BouncingButton(
            child: Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.mp_w_4 * 0.95),
                child: Icon(
                  FontAwesomeIcons.lightArrowDownWideShort,
                  color: AppColors.darkBlue,
                  size: AppSizes.icon_size_6 * 0.7,
                ),
              ),
            ),
            onPressed: () {
              showDialog<bool>(
                context: context,
                builder: (context) {
                  return const DialogSortChallenges();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  buildFloatingActionButton() {
    return Container(
      width: AppSizes.icon_size_18,
      height: AppSizes.icon_size_18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizes.radius_12 * 100,
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.gradientTwoColorOne,
            AppColors.gradientTwoColorTwo,
          ],
        ),
      ),
      child: FloatingActionButton(
        backgroundColor: AppColors.transparent,
        heroTag: Constants.fabHeroTagTwo,
        child: Center(
          child: Icon(
            FontAwesomeIcons.solidUserPlus,
            size: AppSizes.icon_size_6 * 0.8,
            color: AppColors.white,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRouterPaths.createGroup,);
        },
      ),
    );
  }

  Widget buildSelectedFilteringItems(String text) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(AppSizes.radius_2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkBlue,
                  fontSize: AppSizes.font_9,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Icon(
            FontAwesomeIcons.xmark,
            size: AppSizes.icon_size_4 * 0.7,
            color: AppColors.darkBlue,
          ),
          SizedBox(
            width: AppSizes.mp_w_2,
          ),
        ],
      ),
    );
  }
}
