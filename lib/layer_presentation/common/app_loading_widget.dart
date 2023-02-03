import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppSizes.mp_v_10,
          ),
          Container(
            width: AppSizes.icon_size_32 * 1.5,
            height: AppSizes.icon_size_32 * 1.5,
            child: Lottie.asset(AppAssets.infinityLoading,fit: BoxFit.contain),
          ),
          SizedBox(
            height: AppSizes.mp_v_1,
          ),
          Text(
            "Loading ...",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkBlue,
                  fontSize: AppSizes.font_14,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
