import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemGroupGamePlayerForfitCard extends StatelessWidget {
  const ItemGroupGamePlayerForfitCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.mp_v_2),
      child: Material(
        elevation: 2,
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        child: AppCard(
          radius: AppSizes.radius_12,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Lottie.asset(
                  AppAssets.failureLottie,
                  width: AppSizes.icon_size_12,
                  fit: BoxFit.cover,
                ),

                SizedBox(
                  height: AppSizes.mp_v_1,
                ),

                ///BUILD DIALOG TITLE
                Text(
                  "Level Failed",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.red,
                    fontSize: AppSizes.font_12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: AppSizes.mp_v_4,
                ),

                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: AppSizes.font_9,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(
                  height: AppSizes.mp_v_4,
                ),

                Row(
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
                          'Continue',
                          textAlign: TextAlign.center,
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
            ),
          ),
        ),
      ),
    );

  }
}
