import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemSearchResult extends StatelessWidget {
  const ItemSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppSizes.mp_w_4,),
        CircleAvatar(
          radius: AppSizes.icon_size_6 *0.95,
          backgroundColor: AppColors.gold,
          child: CircleAvatar(
            radius: AppSizes.icon_size_6*0.9 ,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
            ),
          ),
        ),
        SizedBox(
          width: AppSizes.mp_w_3,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bet Sports",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.font_12 - 3,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1 / 2,
              ),
              Text(
                "⚽ Sports",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.darkGrey,
                      fontSize: AppSizes.font_9 ,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: AppSizes.mp_w_6,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.solidCircleDollar,
                  color: AppColors.gold,
                  size: AppSizes.icon_size_4*0.8,
                ),
                SizedBox(
                  width: AppSizes.mp_w_1,
                ),
                Text(
                  "124,000 ETB",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontSize: AppSizes.font_9,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.solidUsersLine,
                  color: AppColors.darkBlue,
                  size: AppSizes.icon_size_4*0.8,
                ),
                SizedBox(
                  width: AppSizes.mp_w_2,
                ),
                Text(
                  "124 Members",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkBlue,
                    fontSize: AppSizes.font_9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
