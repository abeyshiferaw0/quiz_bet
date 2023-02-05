import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_checker/game_checker_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_gmae_history_saver/game_history_saver_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/game_player_page/game_player_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemGameLevelsComplited extends StatefulWidget {
  const ItemGameLevelsComplited(
      {Key? key,})
      : super(key: key);



  @override
  State<ItemGameLevelsComplited> createState() => _ItemGameLevelsComplitedState();
}

class _ItemGameLevelsComplitedState extends State<ItemGameLevelsComplited> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppSizes.radius_12,
      child: Material(
        elevation: 2,
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        child:  Stack(
      children: [
      Opacity(
      opacity: 0.2,
        child: Lottie.asset(
          AppAssets.fireWorkLottie,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [



          Text(
            "GAME COMPLETED".toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.green,
              fontSize: AppSizes.font_22,
              fontWeight: FontWeight.bold,
            ),
          ),

          ///CONGRATULATIONS HEADER
          // buildCongratulationsHeader(context),

          SizedBox(
            height: AppSizes.mp_v_1,
          ),

          SizedBox(
            height: AppSizes.mp_v_4,
          ),

          // ///BUILD ACTION BUTTONS
          // buildActionButtons(context),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.darkBlue,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_4,
                ),
                shape: RoundedRectangleBorder(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PLAY ANOTHER GAME',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.white,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.mp_w_6,
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRightLong,
                    size: AppSizes.icon_size_6,
                    color: AppColors.white,
                  ),
                ],
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


  buildCongratulationsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "GAME COMPLETED".toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.green,
                fontSize: AppSizes.font_28,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          width: AppSizes.mp_w_2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: AppSizes.mp_v_4 * 0.8,
          ),
          child: Lottie.asset(
            AppAssets.trumpateLottie,
            width: AppSizes.icon_size_12,
            height: AppSizes.icon_size_12,
          ),
        ),
      ],
    );
  }

  buildTopProgress(context) {
    return SizedBox(
      height: AppSizes.icon_size_4 * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radius_12),
        ),
        child: LinearProgressIndicator(
          value: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.green,
          ),
          backgroundColor: AppColors.lightGrey,
        ),
      ),
    );
  }

  Row buildInfoItem(
      BuildContext context, String title, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.font_9,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.font_9,
              ),
        ),
      ],
    );
  }

  buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.darkBlue,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      AppSizes.radius_6,
                    ),
                  ),
                ),
              ),
              onPressed: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Level Up And Win',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.gold,
                              fontSize: AppSizes.font_10,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Text(
                        'DONE',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.white,
                              fontSize: AppSizes.font_12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AppSizes.mp_w_6,
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRightLong,
                    size: AppSizes.icon_size_6,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: AppSizes.mp_v_4,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                foregroundColor: AppColors.grey,
                backgroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                ),
                shape: RoundedRectangleBorder(
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
                'Back To Home',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.darkGold,
                      fontSize: AppSizes.font_10,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
