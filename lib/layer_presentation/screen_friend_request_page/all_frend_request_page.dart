import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/dialog_friend_request_reject.dart';
import 'package:quiz_bet/layer_presentation/common/dilaog_friend_request_accept.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';


class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({Key? key}) : super(key: key);

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: AppSizes.mp_v_1,
              ),

              ///BUILD APP BAR
              buildAppBar(),

              SizedBox(
                height: AppSizes.mp_v_2,
              ),

              ///BUILD FRIEND ACCEPTANCE REJECTION CARD
              buildFriendAcceptanceResectionCard(),
            ],
          ),
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
      margin: EdgeInsets.only(
        left: AppSizes.mp_w_4,
        right: AppSizes.mp_w_4,
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: AppColors.gold,
              size: AppSizes.icon_size_6,
            ),
          ),
          Text(
            "Hamlemal Niggusie",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
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
                  radius: AppSizes.icon_size_6 * 0.9,
                  backgroundColor: AppColors.darkGold,
                  child: CircleAvatar(
                    radius: AppSizes.icon_size_6 * 0.83,
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
                      "Time Remaining",
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
                      "2Hr : 34Min : 42Sec",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.gold,
                            fontSize: AppSizes.font_12,
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
                                return const DialogFriendRequestAccept();
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
    );
  }
}
