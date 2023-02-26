import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_presentation/common/app_custom_tab_indicator.dart';
import 'package:quiz_bet/layer_presentation/screen_add_members/widgets/tab_invite_by_id.dart';
import 'package:quiz_bet/layer_presentation/screen_add_members/widgets/tab_page_qr_code.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AddMembersPage extends StatefulWidget {
  const AddMembersPage({Key? key, required this.quizId}) : super(key: key);

  final String quizId;

  @override
  State<AddMembersPage> createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Column(
            children: [
              ///BUILD APP BAR
              buildAppBar(),

              SizedBox(
                height: AppSizes.mp_v_1 / 2,
              ),

              ///BUILD TAB BARS
              buildTabBar(context),

              SizedBox(
                height: AppSizes.mp_v_2,
              ),

              Divider(
                color: AppColors.lightGrey,
              ),

              Expanded(
                child: Stack(
                  children: [
                    ///BUILD TAB PAGES
                    Align(
                      alignment: Alignment.topCenter,
                      child: buildTabPages(),
                    ),

                    ///BUILD FINISH BUTTON
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: buildFinishButton(),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: AppSizes.mp_v_1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TabBar buildTabBar(BuildContext context) {
    return TabBar(
      indicator: const CustomTabIndicator(),
      labelPadding: EdgeInsets.zero,
      labelColor: AppColors.darkBlue,
      isScrollable: false,
      unselectedLabelColor: AppColors.darkGrey,
      labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font_12,
          ),
      unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.font_12,
          ),
      tabs: [
        buildTabItems("Scan Qr-code"),
        buildTabItems("Add By Id"),
      ],
    );
  }

  buildTabPages() {
    return TabBarView(
      children: [
        TabPageFriends(
          quizId: widget.quizId,
        ),
        TabInviteById(),
      ],
    );
  }

  Tab buildTabItems(String title) {
    return Tab(
      child: Text(title),
    );
  }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_2,
        horizontal: AppSizes.mp_w_4,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
        vertical: AppSizes.mp_v_2,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BouncingButton(
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              size: AppSizes.icon_size_6,
              color: AppColors.gold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Text(
            "Add Members",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  buildFinishButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.black,
          backgroundColor: AppColors.darkBlue,
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_2 * 1.2,
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
          'Finish',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.white,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
