import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.darkBlue,
        padding: EdgeInsets.only(left: AppSizes.mp_w_10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSizes.mp_v_6,
            ),

            ///BUILD HEADER
            buildHeader(context),

            ///BUILD MENU LIST
            buildMenusList(context),

            Divider(
              color: AppColors.white,
            ),

            SizedBox(
              height: AppSizes.mp_v_1,
            ),

            ///BUILD FOOTER
            buildFooter(context),

            SizedBox(
              height: AppSizes.mp_v_6,
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildMenusList(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.mp_v_6,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.bellOn,
              title: "Notification",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.circleUser,
              title: "Profile",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.clockRotateLeft,
              title: "History",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.circleQuestion,
              title: "Trending Quiz",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.barcodeRead,
              title: "Scan & Join",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.wallet,
              title: "Wallet",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.gear,
              title: "Settings",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.circleInfo,
              title: "About Us",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.moon,
              title: "Dark Mode",
              onTap: () {},
            ),
            SizedBox(
              height: AppSizes.mp_v_1,
            ),
            buildSideBarMenuItem(
              context: context,
              icon: FontAwesomeIcons.blockQuestion,
              title: "Help",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppAssets.appLogo,
          width: AppSizes.icon_size_10,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: AppSizes.mp_w_4,
        ),
        Text(
          "QUIZ BET".toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.white,
                fontSize: AppSizes.font_20,
                fontWeight: FontWeight.w100,
              ),
        ),
      ],
    );
  }

  buildSideBarMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return BouncingButton(
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_1,
          horizontal: AppSizes.mp_w_4,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppSizes.icon_size_4,
              color: AppColors.gold,
            ),
            SizedBox(
              width: AppSizes.mp_w_6,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.lightWhite,
                    fontSize: AppSizes.font_9,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  buildFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Version 1.01",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.white,
                fontSize: AppSizes.font_9,
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          "@Copy right reserved",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.lightWhite,
            fontSize: AppSizes.font_8,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
