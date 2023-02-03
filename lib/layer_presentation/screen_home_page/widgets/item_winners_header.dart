import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/color_util.dart';
import 'package:sizer/sizer.dart';

class ItemWinnersHeader extends StatelessWidget {
  const ItemWinnersHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius_8),
        gradient: LinearGradient(
          colors: [
            AppColors.gradientOneColorOne,
            AppColors.gradientOneColorTwo,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radius_8),
                color: AppColors.completelyBlack.withOpacity(0.2),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: AppSizes.mp_v_4,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildMedalWidget(context, AppColors.lightWhite),
                  Transform.scale(
                    scale: 1.2,
                    child: buildMedalWidget(context, AppColors.gold),
                  ),
                  buildMedalWidget(context, AppColors.darkGold),
                ],
              ),

              Text(
                "January sport quiz winners",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontSize: AppSizes.font_10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(
              //   height: AppSizes.mp_v_2,
              // ),
            ],
          )
        ],
      ),
    );
  }

  buildMedalWidget(context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "250K",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
                fontSize: AppSizes.font_10,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        SizedBox(
          //width: 15.w,
          height: 10.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.rotate(
                      angle: 120,
                      child: Icon(
                        FontAwesomeIcons.solidBookmark,
                        size: AppSizes.icon_size_6,
                        color: color,
                      ),
                    ),
                    Transform.rotate(
                      angle: -120,
                      child: Icon(
                        FontAwesomeIcons.solidBookmark,
                        size: AppSizes.icon_size_6,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: AppSizes.icon_size_6*0.9,
                  backgroundColor: color,
                  child: CircleAvatar(
                    radius: AppSizes.icon_size_6 * 0.85,
                    backgroundColor: AppColors.white,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
