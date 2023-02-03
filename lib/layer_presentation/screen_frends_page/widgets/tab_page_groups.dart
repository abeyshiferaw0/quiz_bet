import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class TabPageGroups extends StatelessWidget {
  const TabPageGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_6,
        vertical: AppSizes.mp_v_4,
      ),
      shrinkWrap: false,
      itemBuilder: (context, index) {
        return buildGroupItem(context);
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_1 / 2,
          ),
          child: Divider(
            color: AppColors.lightGrey,
          ),
        );
      },
      itemCount: 1,
    );
  }

   buildGroupItem(BuildContext context) {
    return BouncingButton(
      onPressed: (){
        Navigator.pushNamed(context, AppRouterPaths.groupDetailPage);
      },

      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSizes.icon_size_6,
              backgroundColor: AppColors.darkGold,
              child: CircleAvatar(
                radius: AppSizes.icon_size_6 * 0.95,
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
                    "Dazzlers",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.font_12,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_1 / 2,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      buildSmallGroupImage(),
                      Positioned(
                        left: 0,
                        right: -AppSizes.mp_w_6,
                        top: 0,
                        bottom: 0,
                        child: buildSmallGroupImage(),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        right: -AppSizes.mp_w_6 * 2,
                        child: buildSmallGroupImage(),
                      ),
                    ],
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
                      "3",
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
        ),
      ),
    );
  }

  buildSmallGroupImage() {
    return CircleAvatar(
      radius: AppSizes.icon_size_4 * 0.6,
      backgroundColor: AppColors.white,
      child: CircleAvatar(
        radius: AppSizes.icon_size_4 * 0.5,
        backgroundColor: AppColors.black,
        backgroundImage: NetworkImage(
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
        ),
        child: CircleAvatar(
          backgroundColor: AppColors.completelyBlack.withOpacity(0.2),
        ),
      ),
    );
  }
}
