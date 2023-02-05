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

class ItemGameResultCard extends StatefulWidget {
  const ItemGameResultCard(
      {Key? key,
      required this.amountToBet,
      required this.vatPer,
      required this.gameLevel,
      required this.nextLevel,
      required this.gameInfo, required this.timeTaken})
      : super(key: key);

  final int amountToBet;
  final double vatPer;
  final GameLevel gameLevel;
  final GameLevel nextLevel;
  final GameInfo gameInfo;
  final int timeTaken;

  @override
  State<ItemGameResultCard> createState() => _ItemGameResultCardState();
}

class _ItemGameResultCardState extends State<ItemGameResultCard> {
  @override
  void initState() {
    context.read<GameHistorySaverBloc>().add(
          GameHistorySaverSaveEvent(
            gameInfo: widget.gameInfo,
            gameLevel: widget.gameLevel,
              timeTaken:widget.timeTaken,
          ),
        );

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
        child: BlocBuilder<GameHistorySaverBloc, GameHistorySaverState>(
          builder: (context, state) {
            if (state is GameHistorySaverLoadingState) {
              return const AppLoadingWidget();
            }
            if (state is GameHistorySaverLoadingErrorState) {
              return AppErrorWidget(
                onTryAgain: () {
                  context.read<GameHistorySaverBloc>().add(
                        GameHistorySaverSaveEvent(
                          gameInfo: widget.gameInfo,
                          gameLevel: widget.gameLevel,
                          timeTaken:widget.timeTaken,
                        ),
                      );
                },
              );
            }
            if (state is GameHistorySaverLoadedState) {
              return buildLoadedView(context);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Stack buildLoadedView(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.2,
          child: Lottie.asset(
            AppAssets.fireWorkLottie,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///BUILD TOP LINER PROGRESS
              buildTopProgress(context),

              SizedBox(
                height: AppSizes.mp_v_1,
              ),

              ///CONGRATULATIONS HEADER
              buildCongratulationsHeader(context),

              SizedBox(
                height: AppSizes.mp_v_1,
              ),

              ///BUILD QUESTION
              buildPrizeInfoInfo(context),

              SizedBox(
                height: AppSizes.mp_v_4,
              ),

              ///PRIZE DETAIL INFO
              buildPrizeDetailContainer(context),

              SizedBox(
                height: AppSizes.mp_v_4,
              ),

              ///BUILD ACTION BUTTONS
              buildActionButtons(context),

              SizedBox(
                height: AppSizes.mp_v_2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildCongratulationsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "CONGRATULATIONS".toUpperCase(),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.green,
                fontSize: AppSizes.font_12,
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

  buildPrizeDetailContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_v_1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prize",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              buildInfoItem(
                context,
                "Deposit",
                "${widget.amountToBet.toStringAsFixed(2)} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "VAT 15%",
                "${widget.vatPer.toStringAsFixed(2)} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "Placed Bet",
                "${(widget.amountToBet - widget.vatPer).toStringAsFixed(2)} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "Total Odd",
                "${widget.gameLevel.odd.toStringAsFixed(2)} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "To Win",
                "${(widget.amountToBet * widget.gameLevel.odd).toStringAsFixed(2)} ETB",
                AppColors.darkGold,
              ),
            ],
          ),
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

  buildPrizeInfoInfo(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
      ),
      width: double.infinity,
      child: Material(
        color: AppColors.gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_2,
            horizontal: AppSizes.mp_w_6,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 5,
                child: Lottie.asset(
                  AppAssets.winnerBadgeLottie,
                  width: AppSizes.icon_size_4,
                  height: AppSizes.icon_size_4,
                ),
              ),
              SizedBox(
                width: AppSizes.mp_w_6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Winning Prize",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkBlue,
                          fontSize: AppSizes.font_10,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_1 / 2,
                  ),
                  Text(
                    "${(widget.amountToBet).toStringAsFixed(2)} * ${widget.gameLevel.odd.toStringAsFixed(2)} = ${((widget.amountToBet) * widget.gameLevel.odd).toStringAsFixed(2)}",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.gold,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                ///START PLAYING INITIAL GAME LEVEL
                context.read<GameCheckerBloc>().add(
                  CheckAnswerShowNextLevelCountDownEvent( gameLevel: widget.gameLevel,  timeTaken: widget.timeTaken,
                  ),
                );
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
                        '${((widget.amountToBet * widget.nextLevel.odd) + (widget.amountToBet * widget.gameLevel.odd)).toStringAsFixed(2)} ETB',
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
