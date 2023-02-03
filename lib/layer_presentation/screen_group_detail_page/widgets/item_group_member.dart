import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemGroupMember extends StatelessWidget {
  const ItemGroupMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onPressed: () {

      },
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.icon_size_8 * 0.75,
            backgroundColor: AppColors.gold,
            child: CircleAvatar(
              radius: AppSizes.icon_size_8 * 0.7,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
              ),
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hallelujah Nigusse",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font_9,
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 2,
                ),
                Text(
                  "Only those who dare to fail greatly can ever achieve greatly",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_9 - 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_6,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.check,
                color: AppColors.green,
                size: AppSizes.icon_size_4*0.7,
              ),
              SizedBox(
                width: AppSizes.mp_w_1,
              ),
              Text(
                "Accepted",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.green,
                  fontSize: AppSizes.font_9*0.9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
