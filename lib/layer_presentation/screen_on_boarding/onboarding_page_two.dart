import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_presentation/screen_on_boarding/widgets/item_onboard_circle.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class OnBoardingPageTwo extends StatefulWidget {
  const OnBoardingPageTwo(
      {Key? key, required this.onNextTap, required this.onPrvTap})
      : super(key: key);

  final VoidCallback onNextTap;
  final VoidCallback onPrvTap;

  @override
  State<OnBoardingPageTwo> createState() => _OnBoardingPageTwoState();
}

class _OnBoardingPageTwoState extends State<OnBoardingPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
        //  width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset(
                  AppAssets.onboardBirr,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: AppSizes.mp_v_1,),
              Text(
                "Winner Takes All",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.darkGold,
                      fontSize: AppSizes.font_14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: AppSizes.mp_v_1,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
                child: Text(
                  "you can simply win more tha 250,000 birr just by answering questions",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.mp_v_10*2,),
            ],
          ),
        ),

        ///BUILD BUTTONS
        buildActionButtons(context),
      ],
    );
  }

  Align buildActionButtons(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.mp_w_4,
          vertical: AppSizes.mp_v_2,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_2,
                  ),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppSizes.radius_6,
                      ),
                    ),
                  ),
                ),
                onPressed: widget.onPrvTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: AppSizes.icon_size_4,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_2,
                    ),
                    Text(
                      'Previous',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.black,
                            fontSize: AppSizes.font_12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: AppSizes.mp_w_4,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_2,
                  ),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppSizes.radius_6,
                      ),
                    ),
                  ),
                ),
                onPressed: widget.onNextTap,
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
          ],
        ),
      ),
    );
  }
}
