import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group_joined_subscription/game_group_joined_subscription_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_group_joined_subscription.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class JoinedPlayersList extends StatelessWidget {
  const JoinedPlayersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameGroupJoinedSubscriptionBloc,
        GameGroupJoinedSubscriptionState>(
      builder: (context, state) {
        if (state is GameGroupJoinedSubState) {
          if (state.gameGroupJoinedSubscriptions.isNotEmpty) {
            return buildJoinedView(context, state.gameGroupJoinedSubscriptions);
          }
        }
        return SizedBox();
      },
    );
  }

  Container buildJoinedView(
      context, List<GameGroupJoinedSubscription> gameGroupJoinedSubscriptions) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
        vertical: AppSizes.mp_v_1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          Row(
            children: [
              Text(
                "Joined Players",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_2,
              ),
              CircleAvatar(
                backgroundColor: AppColors.gold,
                radius: AppSizes.icon_size_4,
                child: Center(
                  child: Text(
                    gameGroupJoinedSubscriptions.length.toString(),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildJoinedItem(
                context,
                gameGroupJoinedSubscriptions.elementAt(index),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: AppSizes.mp_v_1,
              );
            },
            itemCount: gameGroupJoinedSubscriptions.length,
          ),
        ],
      ),
    );
  }

  Material buildJoinedItem(BuildContext context,
      GameGroupJoinedSubscription gameGroupJoinedSubscription) {
    return Material(
      borderRadius: BorderRadius.circular(AppSizes.radius_6),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.mp_w_4,
          vertical: AppSizes.mp_v_1,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSizes.icon_size_6 * 0.95,
              backgroundColor: AppColors.gold,
              child: CircleAvatar(
                radius: AppSizes.icon_size_6 * 0.9,
                backgroundColor: AppColors.darkBlue,
                child: Text(
                  gameGroupJoinedSubscription.userName[0].toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font_12 ,
                      ),
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
                    gameGroupJoinedSubscription.userName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.font_12 - 3,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_1 / 2,
                  ),
                  Text(
                    gameGroupJoinedSubscription.phoneNumber,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontSize: AppSizes.font_9 - 2,
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
                            fontSize: AppSizes.font_8,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
