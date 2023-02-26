import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

import 'widgets/dialog_game_balance_not_enough.dart';
import 'widgets/dialog_game_join_accept.dart';
import 'widgets/dialog_game_join_reject.dart';

class JoinGameGameFindPage extends StatefulWidget {
  const JoinGameGameFindPage({
    Key? key, required this.quizId,
  }) : super(key: key);

  final String quizId;

  @override
  State<JoinGameGameFindPage> createState() => _JoinGameGameFindPageState();
}

class _JoinGameGameFindPageState extends State<JoinGameGameFindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///BUILD APP BAR
            buildAppBar(),


           Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
      horizontal: AppSizes.mp_w_4,
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
                  vertical: AppSizes.mp_v_1 / 3,
                ),
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.grey,
                        fontSize: AppSizes.font_12,
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
                          size: AppSizes.icon_size_4,
                          color: AppColors.darkBlue,
                        ),
                        SizedBox(
                          width: AppSizes.mp_w_2,
                        ),
                        Text(
                          "Sport",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.darkBlue,
                            fontSize: AppSizes.font_14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                  vertical: AppSizes.mp_v_1 / 3,
                ),
                child: Row(
                  children: [
                    Text(
                      "Betting Money",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.grey,
                        fontSize: AppSizes.font_12,
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
                        fontSize: AppSizes.font_14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                  vertical: AppSizes.mp_v_1 / 3,
                ),
                child: Row(
                  children: [
                    Text(
                      "Selected Level",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.grey,
                        fontSize: AppSizes.font_12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      "Level One",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_14,
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
                  vertical: AppSizes.mp_v_1 / 3,
                ),
                child: Divider(
                  color: AppColors.gold,
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mp_w_4,
                  vertical: AppSizes.mp_v_1 / 3,
                ),
                child: Row(
                  children: [
                    Text(
                      "Winning Prize",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.grey,
                        fontSize: AppSizes.font_12,
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
                        fontSize: AppSizes.font_14,
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
                          vertical: AppSizes.mp_v_2*0.7,
                        ),
                        child: BouncingButton(
                          onPressed: () {



                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogGameJoinReject();
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
                                fontSize: AppSizes.font_12,
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
                          vertical: AppSizes.mp_v_2*0.7,
                        ),
                        child: BouncingButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return const DialogGameBalanceNotEnough();
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
                                fontSize: AppSizes.font_12,
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
    ),
          ],
        ),
      ),
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
                onPressed: () {},
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
}
