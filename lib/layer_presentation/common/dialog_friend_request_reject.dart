import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class DialogFriendRequestReject extends StatelessWidget {
  const DialogFriendRequestReject({Key? key}) : super(key: key);

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

                Icon(
                  FontAwesomeIcons.hexagonXmark,
                  size: AppSizes.icon_size_6,
                  color: AppColors.red,
                ),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                ///BUILD DIALOG TITLE
                Text(
                  "Decline an offer",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.red,
                        fontSize: AppSizes.font_12,
                        fontWeight: FontWeight.w600,
                      ),
                ),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                Text(
                  "Once you accept the betting offer you can not go back and get a refund",
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
                          'Cancel',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.darkBlue,
                                    fontSize: AppSizes.font_10,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_2,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor: AppColors.red,
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
                          'Reject',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.white,
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
        ],
      ),
    );
  }
}
