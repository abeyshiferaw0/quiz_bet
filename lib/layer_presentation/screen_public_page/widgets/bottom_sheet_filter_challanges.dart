import 'package:another_xlider/another_xlider.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class BottomSheetFilterChallenges extends StatelessWidget {
  BottomSheetFilterChallenges({Key? key}) : super(key: key);

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
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.radius_6 * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSizes.mp_v_4,
              ),

              ///BUILD DIALOG TITLE
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Filter the challenges",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: AppSizes.font_14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(
                height: AppSizes.mp_v_4,
              ),

              ///QUIZ STARTING TIME FILTER
              buildQuizStartingTimeFilter(context),

              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.mp_v_1,
                  bottom: AppSizes.mp_v_2 * 0.8,
                ),
                child: Divider(
                  color: AppColors.darkBlue.withOpacity(0.2),
                ),
              ),

              ///NUMBER OF PLAYERS FILTER
              buildNumberOfPlayersFilter(context),

              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.mp_v_1,
                  bottom: AppSizes.mp_v_2 * 0.8,
                ),
                child: Divider(
                  color: AppColors.darkBlue.withOpacity(0.2),
                ),
              ),

              ///FILTER CATEGORIES
              buildFilterCategories(context),

              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.mp_v_2,
                  bottom: AppSizes.mp_v_2 * 0.8,
                ),
                child: Divider(
                  color: AppColors.darkBlue.withOpacity(0.2),
                ),
              ),

              ///FILTER PRIZE AMOUNT
              buildPrizeAmount(context),

              SizedBox(
                height: AppSizes.mp_v_2 ,
              ),

              ///BUILD CANCEL AND APPLY BUTTONS
              buildCancelAndApply(context),

              SizedBox(
                height: AppSizes.mp_v_2 ,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildQuizStartingTimeFilter(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quiz Starting Time",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.gold,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_6 * 0.8,
                  vertical: AppSizes.mp_v_1 * 0.8,
                ),
                child: Text(
                  "27",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
                child: FlutterSlider(
                  values: [30, 420],
                  rangeSlider: true,
                  max: 500,
                  min: 0,
                  handlerWidth: AppSizes.icon_size_6,
                  handlerHeight: AppSizes.icon_size_6,
                  handler: FlutterSliderHandler(
                    child: Icon(
                      FontAwesomeIcons.solidChevronLeft,
                      size: AppSizes.icon_size_4 * 0.8,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    child: Icon(
                      color: AppColors.darkGrey,
                      FontAwesomeIcons.solidChevronRight,
                      size: AppSizes.icon_size_4 * 0.8,
                    ),
                  ),
                  tooltip: FlutterSliderTooltip(
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: AppSizes.font_10,
                          fontWeight: FontWeight.w600,
                        ),
                    boxStyle: FlutterSliderTooltipBox(
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarHeight: AppSizes.icon_size_2 * 0.7,
                    inactiveTrackBarHeight: AppSizes.icon_size_2 * 0.7,
                    activeTrackBar: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    ),
                    inactiveTrackBar: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    // _lowerValue = lowerValue;
                    // _upperValue = upperValue;
                    // setState(() {});
                  },
                ),
              ),
            ),
            Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_6 * 0.8,
                  vertical: AppSizes.mp_v_1 * 0.8,
                ),
                child: Text(
                  "200",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildNumberOfPlayersFilter(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Number of Players",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.gold,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_6 * 0.8,
                  vertical: AppSizes.mp_v_1 * 0.8,
                ),
                child: Text(
                  "27",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
                child: FlutterSlider(
                  values: [30, 420],
                  rangeSlider: true,
                  max: 500,
                  min: 0,
                  handlerWidth: AppSizes.icon_size_6,
                  handlerHeight: AppSizes.icon_size_6,
                  handler: FlutterSliderHandler(
                    child: Icon(
                      FontAwesomeIcons.solidChevronLeft,
                      size: AppSizes.icon_size_4 * 0.8,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    child: Icon(
                      color: AppColors.darkGrey,
                      FontAwesomeIcons.solidChevronRight,
                      size: AppSizes.icon_size_4 * 0.8,
                    ),
                  ),
                  tooltip: FlutterSliderTooltip(
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: AppSizes.font_10,
                          fontWeight: FontWeight.w600,
                        ),
                    boxStyle: FlutterSliderTooltipBox(
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarHeight: AppSizes.icon_size_2 * 0.7,
                    inactiveTrackBarHeight: AppSizes.icon_size_2 * 0.7,
                    activeTrackBar: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    ),
                    inactiveTrackBar: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    // _lowerValue = lowerValue;
                    // _upperValue = upperValue;
                    // setState(() {});
                  },
                ),
              ),
            ),
            Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_6 * 0.8,
                  vertical: AppSizes.mp_v_1 * 0.8,
                ),
                child: Text(
                  "200",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildFilterCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.gold,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        Container(
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
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        SizedBox(
          height: 8.h,
          child: MasonryGridView.count(
            //padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_3),
            itemCount: selectedFilters.length,
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.mp_w_1,
            mainAxisSpacing: AppSizes.mp_w_1,
            itemBuilder: (context, index) {
              return buildSelectedFilteringItems(
                context,
                selectedFilters.elementAt(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildSelectedFilteringItems(context, String text) {
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

  buildPrizeAmount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prize amount",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.gold,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_6 * 0.8,
                  vertical: AppSizes.mp_v_1 * 0.8,
                ),
                child: Text(
                  "27",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
                child: FlutterSlider(
                  values: [30, 420],
                  rangeSlider: true,
                  max: 500,
                  min: 0,
                  handlerWidth: AppSizes.icon_size_6,
                  handlerHeight: AppSizes.icon_size_6,
                  handler: FlutterSliderHandler(
                    child: Icon(
                      FontAwesomeIcons.solidChevronLeft,
                      size: AppSizes.icon_size_4 * 0.8,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    child: Icon(
                      color: AppColors.darkGrey,
                      FontAwesomeIcons.solidChevronRight,
                      size: AppSizes.icon_size_4 * 0.8,
                    ),
                  ),
                  tooltip: FlutterSliderTooltip(
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: AppSizes.font_10,
                          fontWeight: FontWeight.w600,
                        ),
                    boxStyle: FlutterSliderTooltipBox(
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarHeight: AppSizes.icon_size_2 * 0.7,
                    inactiveTrackBarHeight: AppSizes.icon_size_2 * 0.7,
                    activeTrackBar: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    ),
                    inactiveTrackBar: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    // _lowerValue = lowerValue;
                    // _upperValue = upperValue;
                    // setState(() {});
                  },
                ),
              ),
            ),
            Material(
              color: AppColors.lightWhite,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_6 * 0.8,
                  vertical: AppSizes.mp_v_1 * 0.8,
                ),
                child: Text(
                  "200",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
      ],
    );
  }

  buildCancelAndApply(context) {
    return Row(
      children: [
        ///BUILD CANCEL BUTTON
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.black,
              backgroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_2 * 0.8,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.darkBlue),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppSizes.radius_6,
                  ),

                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: AppSizes.font_10,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.mp_w_2,),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.darkBlue,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_2 * 0.8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppSizes.radius_6,
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Apply',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontSize: AppSizes.font_10,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
