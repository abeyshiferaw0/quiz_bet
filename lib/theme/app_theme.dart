import 'package:flutter/material.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';


class AppTheme {

  static ThemeData theme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: AppColors.gold,
    ),

    ///COLORS
    primaryColor: AppColors.gold,
    backgroundColor: AppColors.white,
    dividerColor: AppColors.grey,
    scaffoldBackgroundColor: AppColors.white,
    dialogBackgroundColor: AppColors.white,

    ///TEXT STYLES
    textTheme: TextTheme(
      bodySmall: CustomTextStyles.bodySmall,
      bodyMedium: CustomTextStyles.bodyMedium,
      bodyLarge: CustomTextStyles.bodyLarge,
      headlineSmall: CustomTextStyles.headlineSmall,
      headlineMedium: CustomTextStyles.headlineMedium,
      headlineLarge: CustomTextStyles.headlineLarge,
    ),

  );
  

}

class CustomTextStyles {
  /*
  text color based on app current theme
  color:  AppColors.black,
  */

  static final bodySmall = TextStyle(
    fontSize: AppSizes.font_10,
    color:  AppColors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
  );

  static final bodyMedium = TextStyle(
    fontSize: AppSizes.font_12,
    color:  AppColors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
  );

  static final bodyLarge = TextStyle(
    fontSize: AppSizes.font_14,
    color:  AppColors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
  );

  static final headlineSmall = TextStyle(
    fontSize: AppSizes.font_16,
    color:  AppColors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
  );

  static final headlineMedium = TextStyle(
    fontSize: AppSizes.font_18,
    color:  AppColors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
  );

  static final headlineLarge = TextStyle(
    fontSize: AppSizes.font_20,
    color:  AppColors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
  );
}




