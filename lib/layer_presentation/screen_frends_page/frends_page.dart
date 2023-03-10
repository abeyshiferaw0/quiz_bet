import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_presentation/common/app_custom_tab_indicator.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

import 'widgets/tab_page_friends.dart';
import 'widgets/tab_page_groups.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                ///BUILD TAB BARS
                buildTabBar(context),

                ///BUILD TAB PAGES
                buildTabPages(),
              ],
            ),

            ///ACTION BUTTONS
            Align(
              alignment: Alignment.bottomCenter,
              child: buildFloatingActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildTabPages() {
    return const Expanded(
      child: TabBarView(
        children: [
          TabPageFriends(),
          TabPageGroups(),
        ],
      ),
    );
  }

  TabBar buildTabBar(BuildContext context) {
    return TabBar(
      indicator: const CustomTabIndicator(),
      labelPadding: EdgeInsets.zero,
      labelColor: AppColors.gold,
      unselectedLabelColor: AppColors.darkGrey,
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font_12,
          ),
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.font_12,
          ),
      tabs: [
        buildTabItems("Recently Played With"),
        buildTabItems("Your Groups"),
      ],
    );
  }

  Tab buildTabItems(String title) {
    return Tab(
      child: Text(title),
    );
  }

  buildFloatingActionButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.mp_v_2),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.mp_w_2,
          ),
          buildLargeButtons(
            FontAwesomeIcons.gamepad,
            "Join Game",
            () {
              Navigator.pushNamed(context, AppRouterPaths.joinGameQrScan);
            },
          ),
          SizedBox(
            width: AppSizes.mp_w_2,
          ),
          buildLargeButtons(
            FontAwesomeIcons.plus,
            "Create Game",
            () {
              Navigator.pushNamed(context, AppRouterPaths.createChallenge);
            },
          ),
          SizedBox(
            width: AppSizes.mp_w_2,
          ),
        ],
      ),
    );
  }

  Expanded buildLargeButtons(IconData icon, String title, VoidCallback onTap) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSizes.radius_12 * 100,
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.gradientTwoColorOne,
              AppColors.gradientTwoColorTwo,
            ],
          ),
        ),
        child: AppButtonFeedBack(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.mp_v_4 * 0.7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  size: AppSizes.icon_size_6 * 0.7,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: AppSizes.mp_w_6,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: AppSizes.font_12 * 0.9,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      // child: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(
      //       AppSizes.radius_12,
      //     ),
      //     gradient: LinearGradient(
      //       colors: [
      //         AppColors.gradientTwoColorOne,
      //         AppColors.gradientTwoColorTwo,
      //       ],
      //     ),
      //   ),
      //   child: FloatingActionButton(
      //     backgroundColor: AppColors.transparent,
      //     elevation: 0,
      //     heroTag: Constants.fabHeroTagOne,
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //
      //         Icon(
      //           FontAwesomeIcons.plus,
      //           size: AppSizes.icon_size_6 * 0.6,
      //           color: AppColors.white,
      //         ),
      //         SizedBox(width: AppSizes.mp_w_4,),
      //         Text(
      //           "Create A Game",
      //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
      //                 color: AppColors.white,
      //                 fontWeight: FontWeight.w600,
      //                 fontSize: AppSizes.font_10,
      //               ),
      //         ),
      //
      //       ],
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pushNamed(AppRouterPaths.createChallenge);
      //     },
      //   ),
      // ),
    );
  }
}
