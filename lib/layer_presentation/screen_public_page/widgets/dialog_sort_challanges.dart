import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class DialogSortChallenges extends StatelessWidget {
  const DialogSortChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_4,
              vertical: AppSizes.mp_v_2,
            ),
            width: 80.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: AppSizes.mp_v_1,
                ),

                ///BUILD DIALOG TITLE
                Text(
                  "Sort the challenges",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_14,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),

                ///BUILD SORT ITEMS
                buildSortItems(context),

                SizedBox(
                  height: AppSizes.mp_v_1,
                ),

                ///BUILD APPLY BUTTON
                SizedBox(
                  width: double.infinity,
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
            ),
          ),
        ],
      ),
    );
  }

  buildSortItems(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSortItem(
          context,
          "Group Name",
          () {},
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        buildSortItem(
          context,
          "Prize",
          () {},
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        buildSortItem(
          context,
          "Category",
          () {},
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
        buildSortItem(
          context,
          "Number of player",
          () {},
        ),
        SizedBox(
          height: AppSizes.mp_v_1,
        ),
      ],
    );
  }

  buildSortItem(context, String title, VoidCallback onTap) {
    return BouncingButton(
      onPressed: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: AppColors.lightWhite,

          borderRadius: BorderRadius.circular(AppSizes.radius_6),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.mp_v_2,
              horizontal: AppSizes.mp_w_6,
            ),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: AppSizes.font_10,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
