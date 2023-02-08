import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_presentation/screen_on_boarding/widgets/item_onboard_circle.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class OnBoardingPageOne extends StatefulWidget {
  const OnBoardingPageOne({Key? key, required this.onNextTap})
      : super(key: key);

  final VoidCallback onNextTap;

  @override
  State<OnBoardingPageOne> createState() => _OnBoardingPageOneState();
}

class _OnBoardingPageOneState extends State<OnBoardingPageOne> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   width: double.infinity,
        //   color: Colors.black.withOpacity(0.05),
        // ),

        Opacity(
          opacity: 0.05,
          child: Image.asset(
            AppAssets.tileBackgroundTwo,
            height: 100.h,
            fit: BoxFit.cover,
          ),
        ),

        ///BUILD CIRCLE ITEMS
        buildCirlceItems(),

        ///BUILD NEXT BUTTON
        buildNextButton(context),
      ],
    );
  }

  Align buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.mp_w_4,
          vertical: AppSizes.mp_v_2,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.white,
            elevation: 8,
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.mp_v_2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppSizes.radius_6,
                ),
              ),
            ),
          ),
          onPressed: () {
            print("object clickeddd");
            widget.onNextTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Next',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_2,
              ),
              Icon(
                FontAwesomeIcons.arrowRight,
                size: AppSizes.icon_size_4,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildCirlceItems() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: -AppSizes.mp_w_2,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_18*1.1,
              color: AppColors.white,
              image: AppAssets.art,
              isAnimated: true,
              title: "Art",
            ),
          ),
          Positioned(
            right: AppSizes.mp_w_1,
            top: AppSizes.mp_v_2,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_26,
              color: AppColors.white,
              image: AppAssets.appCircleLogo,
              isAnimated: false,
              title: "Quiz Bet",
            ),
          ),
          Positioned(
            top: AppSizes.mp_v_10 * 2.1,
            left: AppSizes.mp_w_16,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_16*1.1,
              color: AppColors.white,
              image: AppAssets.astro,
              isAnimated: true,
              title: "Astro",
            ),
          ),
          Positioned(
            left: -AppSizes.mp_w_10,
            top: AppSizes.mp_v_16 * 2.2,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_12*1.1,
              image: AppAssets.poletics,
              color: AppColors.white,
              isAnimated: true,
              title: "Politics",
            ),
          ),
          Positioned(
            left: AppSizes.mp_w_12 * 2.2,
            top: AppSizes.mp_v_16 * 2.6,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_14*1.1,
              image: AppAssets.chemistry,
              color: AppColors.white,
              isAnimated: true,
              title: "Chemistry",
            ),
          ),
          Positioned(
            right: -AppSizes.mp_w_2,
            top: AppSizes.mp_v_16 * 2.0,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_18*1.1,
              color: AppColors.white,
              image: AppAssets.physics,
              isAnimated: true,
              title: "Physics",
            ),
          ),
          Positioned(
            left: -AppSizes.mp_w_10,
            top: AppSizes.mp_v_16 * 3.4,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_20*1.1,
              color: AppColors.white,
              image: AppAssets.history,
              isAnimated: true,
              title: "History",
            ),
          ),
          Positioned(
            right: AppSizes.mp_w_12 * 1.4,
            top: AppSizes.mp_v_16 * 3.4,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_14*1.1,
              image: AppAssets.vocablary,
              color: AppColors.white,
              isAnimated: true,
              title: "Vocabulary",
            ),
          ),
          Positioned(
            left: -AppSizes.mp_w_8,
            top: AppSizes.mp_v_16 * 4.9,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_16*1.1,
              color: AppColors.white,
              image: AppAssets.art,
              isAnimated: true,
              title: "Art",
            ),
          ),
          Positioned(
            left: AppSizes.mp_w_16 * 2.0,
            top: AppSizes.mp_v_16 * 4.5,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_14*1.1,
              color: AppColors.white,
              image: AppAssets.music,
              isAnimated: true,
              title: "Music",
            ),
          ),
          Positioned(
            right: -AppSizes.mp_w_8,
            top: AppSizes.mp_v_16 * 4.5,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_18*1.1,
              color: AppColors.white,
              image: AppAssets.sport,
              isAnimated: true,
              title: "Sport",
            ),
          ),
          Positioned(
            left: AppSizes.mp_w_16 * 2.2,
            top: AppSizes.mp_v_16 * 5.7,
            child: ItemOnboardCircle(
              size: AppSizes.icon_size_20*1.1,
              color: AppColors.white,
              image: AppAssets.history,
              isAnimated: true,
              title: "History",
            ),
          ),
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
