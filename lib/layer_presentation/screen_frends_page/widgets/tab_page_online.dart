import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class TabPageOnline extends StatelessWidget {
  const TabPageOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_6,
        vertical: AppSizes.mp_v_4,
      ),
      itemBuilder: (context, index) {
        return buildOnlineItem(context);
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_1/2,
          ),
          child: Divider(
            color: AppColors.lightGrey,
          ),
        );
      },
      itemCount: 12,
    );
  }

  Row buildOnlineItem(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppSizes.icon_size_8*0.85 ,
          backgroundColor: AppColors.gold,
          child: CircleAvatar(
            radius: AppSizes.icon_size_8 * 0.8,
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
                  fontSize: AppSizes.font_12-3,
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1 / 2,
              ),
              Text(
                "Only those who dare to fail greatly can ever achieve greatly",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_9-2,
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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.solidCircle,
                  color: AppColors.green,
                  size: AppSizes.icon_size_2,
                ),
                SizedBox(
                  width: AppSizes.mp_w_2,
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            CircleAvatar(
              radius: AppSizes.icon_size_4 * 0.6,
              backgroundColor: AppColors.gold,
              child: Center(
                child: Text(
                  "1",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontSize: AppSizes.font_9,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
