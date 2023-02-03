import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/color_util.dart';
import 'package:sizer/sizer.dart';

class ItemBigPrizeHeader extends StatelessWidget {
  const ItemBigPrizeHeader({Key? key}) : super(key: key);

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
                color: AppColors.completelyBlack.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "250,000 ETB",
                textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.gold,
                    fontSize: AppSizes.font_20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: AppSizes.mp_v_1,),

                Text(
                  "⚽️🎱 Sports 🥎🏀",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: AppSizes.mp_v_1,),

                Text(
                  "🔬🧪Science🧪🔬",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: AppSizes.mp_v_2,),

                Text(
                  "🎉  Winner Takes all",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
