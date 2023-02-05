import 'package:flutter/material.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AppPlaceHolderImage extends StatelessWidget {
  const AppPlaceHolderImage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.grey,
      child: Center(child: Image.asset(AppAssets.appLogo,height: AppSizes.icon_size_8,),),
    );
  }
}
