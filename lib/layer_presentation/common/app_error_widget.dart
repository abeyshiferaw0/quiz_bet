import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({Key? key, required this.onTryAgain}) : super(key: key);

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppSizes.mp_v_6,
          ),
          Container(
            width: AppSizes.icon_size_32 * 1.5,
            height: AppSizes.icon_size_32 * 1.5,
            child: Lottie.asset(AppAssets.networkError,fit: BoxFit.contain),
          ),
          SizedBox(
            height: AppSizes.mp_v_1,
          ),
          Text(
            "Network Issues",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkGold,
                  fontSize: AppSizes.font_14,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
            child: Text(
              "You don't have a working internet connection, please check you connection and try agan!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkBlue,
                fontSize: AppSizes.font_10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: AppSizes.mp_v_6,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.gold,
                elevation: 2,
                shadowColor: AppColors.completelyBlack.withOpacity(0.3),
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_4*0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      AppSizes.radius_12*3,
                    ),
                  ),
                ),
              ),
              onPressed: onTryAgain,
              child: Text(
                'Try Again',
                textAlign: TextAlign.center,
                style:
                Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
