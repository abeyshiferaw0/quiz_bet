import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_6,
            vertical: AppSizes.mp_v_1 / 2,
          ),
          itemBuilder: (context, index) {
            return buildTimerItem(context);
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_1 ,
              ),
              child: Divider(
                color: AppColors.grey,
              ),
            );
          },
          itemCount: 12,
        ),
      ),
    );
  }

  Row buildTimerItem(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppSizes.icon_size_8 * 0.8,
          backgroundColor: AppColors.gold,
          child: CircleAvatar(
            radius: AppSizes.icon_size_8 * 0.75,
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
            children: [
              ///ITEM DETAILS
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dazzliers",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.font_12 - 3,
                                  ),
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_1 / 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidUsersLine,
                              color: AppColors.darkBlue,
                              size: AppSizes.icon_size_4 * 0.7,
                            ),
                            SizedBox(
                              width: AppSizes.mp_w_2,
                            ),
                            Text(
                              "123 Members",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.darkBlue,
                                    fontSize: AppSizes.font_8,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidCircleDollar,
                            color: AppColors.green,
                            size: AppSizes.icon_size_4 * 0.7,
                          ),
                          SizedBox(
                            width: AppSizes.mp_w_1,
                          ),
                          Text(
                            "124,000 ETB",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.green,
                                      fontSize: AppSizes.font_8,
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
                            FontAwesomeIcons.solidSportsball,
                            color: AppColors.darkGrey,
                            size: AppSizes.icon_size_4 * 0.7,
                          ),
                          SizedBox(
                            width: AppSizes.mp_w_2,
                          ),
                          Text(
                            "Sports",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.darkGrey,
                                      fontSize: AppSizes.font_8,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: AppSizes.mp_v_2,
              ),

              ///TIME LEFT INDICATOR
              Row(
                children: [
                  SizedBox(
                    child: Lottie.asset(
                      AppAssets.timeGlassLottie,
                      width: AppSizes.icon_size_8,
                    ),
                  ),
                  SizedBox(width: AppSizes.mp_w_2,),
                  Text(
                    "11Hrs : 03 Min : 12 Sec",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.gold,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.font_12 - 3,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
