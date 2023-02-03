import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/dialog_friend_request_reject.dart';
import 'package:quiz_bet/layer_presentation/common/dilaog_friend_request_accept.dart';
import 'package:quiz_bet/layer_presentation/screen_group_detail_page/widgets/item_group_member.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class GroupDetailPage extends StatefulWidget {
  const GroupDetailPage({Key? key}) : super(key: key);

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///BUILD APP BAR
              buildAppBar(),

              ///BUILD ACCEPTANCE REJECTION LIST
              buildChallangesCreated(),

              ///BUILD GROUP MEMBERS
              buildGroupMembers(),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  buildChallangesCreated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.mp_v_2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
          ),
          child: Text(
            "New Challenged Created",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_9,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
          ),
          child: SizedBox(
            width: AppSizes.icon_size_24,
            child: const Divider(
              color: AppColors.gold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_2,
          ),
          child: Row(
            children: List.generate(
              12,
              (index) => buildFriendAcceptanceResectionCard(),
            ),
          ),
        ),
      ],
    );
  }

  buildGroupMembers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.mp_v_4,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
          ),
          child: Text(
            "Group Members",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_9,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
          ),
          child: SizedBox(
            width: AppSizes.icon_size_24,
            child: const Divider(
              color: AppColors.gold,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_v_1,
          ),
          itemBuilder: (context, index) {
            return ItemGroupMember();
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
          itemCount: 12,
        ),
      ],
    );
  }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.appLogo,
                width: AppSizes.icon_size_8 * 0.8,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: AppSizes.mp_w_1,
              ),
              Text(
                "QUIZ BET".toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "150 ETB",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gold,
                      fontSize: AppSizes.font_10,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_2,
              ),
              BouncingButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouterPaths.profilePage,
                  );
                },
                child: CircleAvatar(
                  radius: AppSizes.icon_size_6,
                  backgroundColor: AppColors.darkGold,
                  child: CircleAvatar(
                    radius: AppSizes.icon_size_6 * 0.93,
                    backgroundColor: AppColors.lightWhite,
                    backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildFriendAcceptanceResectionCard() {
    return Container(
      width: 80.w,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_2,
        vertical: AppSizes.mp_v_1,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(AppSizes.radius_10),
        color: AppColors.white,
        elevation: 2,
        child: AppCard(
          radius: AppSizes.radius_10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                ),
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                            fontSize: AppSizes.font_10,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.sportsball,
                          size: AppSizes.icon_size_4 * 0.8,
                          color: AppColors.darkBlue,
                        ),
                        SizedBox(
                          width: AppSizes.mp_w_2,
                        ),
                        Text(
                          "Sport",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.darkBlue,
                                    fontSize: AppSizes.font_10,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                ),
                child: Row(
                  children: [
                    Text(
                      "Betting Money",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                            fontSize: AppSizes.font_10,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      "15 ETB",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.darkBlue,
                            fontSize: AppSizes.font_10,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                ),
                child: Row(
                  children: [
                    Text(
                      "Time Remaining",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                            fontSize: AppSizes.font_10,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      "2Hr : 34Min : 42Sec",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.gold,
                            fontSize: AppSizes.font_10,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Container(
                width: AppSizes.icon_size_10 * 3,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                ),
                child: Divider(
                  color: AppColors.gold,
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                ),
                child: Row(
                  children: [
                    Text(
                      "Winning Prize",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.darkBlue,
                            fontSize: AppSizes.font_10,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      "85 ETB",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.gold,
                            fontSize: AppSizes.font_12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppSizes.radius_10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.red,
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.mp_v_2 * 0.6,
                        ),
                        child: BouncingButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogFriendRequestReject();
                              },
                            );
                          },
                          child: Center(
                            child: Text(
                              "Reject",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.white,
                                    fontSize: AppSizes.font_10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.mp_v_2 * 0.6,
                        ),
                        child: BouncingButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogFriendRequestAccept();
                              },
                            );
                          },
                          child: Center(
                            child: Text(
                              "Accept",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.white,
                                    fontSize: AppSizes.font_10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFloatingActionButton() {
    return Container(
      width: AppSizes.icon_size_18,
      height: AppSizes.icon_size_18,
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
      child: FloatingActionButton(
        backgroundColor: AppColors.transparent,
        heroTag: Constants.fabHeroTagOne,
        child: Icon(
          FontAwesomeIcons.plus,
          size: AppSizes.icon_size_6 * 0.8,
          color: AppColors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRouterPaths.createChallenge,
          );
        },
      ),
    );
  }
}
