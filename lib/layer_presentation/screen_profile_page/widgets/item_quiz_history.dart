import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemQuizHistory extends StatelessWidget {
  const ItemQuizHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: AppColors.lightWhite.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppSizes.radius_10),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_3,
            vertical: AppSizes.mp_v_1,
          ),
          child: Row(
            children: [
              Material(
                color: AppColors.darkBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radius_6),
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.mp_w_3),
                  child: Icon(
                    FontAwesomeIcons.sportsball,
                    color: AppColors.gold,
                    size: AppSizes.icon_size_4,
                  ),
                ),
              ),
              SizedBox(
                width: AppSizes.mp_w_3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sport Quiz",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkBlue,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    "Level 1",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.grey,
                          fontSize: AppSizes.font_9,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jan 22 , 2022",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkGrey,
                          fontSize: AppSizes.font_9,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: AppSizes.mp_v_1,),
                  Text(
                    "6/14",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.grey,
                          fontSize: AppSizes.font_10,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
