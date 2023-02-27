import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_start/game_start_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_initial_info.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class DialogGroupGameConfirmation extends StatefulWidget {
  const DialogGroupGameConfirmation(
      {Key? key,
      required this.gameInitialInfo,
      required this.amountToBet,
      required this.vatPer})
      : super(key: key);

  final GameInitialInfo gameInitialInfo;
  final int amountToBet;
  final double vatPer;

  @override
  State<DialogGroupGameConfirmation> createState() => _DialogGroupGameConfirmationState();
}

class _DialogGroupGameConfirmationState extends State<DialogGroupGameConfirmation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameStartBloc, GameStartState>(
      listener: (context, state) {
        if (state is GameStartLoaded) {
          Navigator.pop(context);
          Navigator.pop(context);

          Navigator.pushNamed(
            context,
            AppRouterPaths.gameStartCountDownPage,
            arguments: ScreenArguments(data: {
              "gameInfo": state.gameInfo,
              "amountToBet": widget.amountToBet,
              "vatPer": widget.vatPer,
            }),
          );
        }
      },
      child: Center(
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.radius_6),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_4,
                vertical: AppSizes.mp_v_2,
              ),
              width: 80.w,
              child: BlocBuilder<GameStartBloc, GameStartState>(
                builder: (context, state) {
                  if (state is GameStartLoading) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: AppSizes.mp_v_4),
                      child: AppLoadingWidget(),
                    );
                  }
                  if (state is GameStartLoadingError) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: AppSizes.mp_v_4),
                      child: AppErrorWidget(
                        onTryAgain: () {
                          context.read<GameStartBloc>().add(
                                StartGameEvent(
                                  category: widget.gameInitialInfo.category,
                                  amountToBet: widget.amountToBet,
                                  initialLevelId:
                                      widget.gameInitialInfo.levels.first.id,
                                ),
                              );
                        },
                      ),
                    );
                  }


                  return buildLoadedView(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildLoadedView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        Icon(
          FontAwesomeIcons.solidCircleInfo,
          size: AppSizes.icon_size_6,
          color: AppColors.gold,
        ),

        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        ///BUILD DIALOG TITLE
        Text(
          "Conformation Dialog",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkGold,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.bold,
              ),
        ),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        Text(
          "Once you have started this SPORT quiz you can not quit no matter what happens.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkBlue,
                fontSize: AppSizes.font_9,
                fontWeight: FontWeight.w400,
              ),
        ),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        Material(
          color: AppColors.gold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSizes.radius_6),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.mp_v_2,
              horizontal: AppSizes.mp_w_6,
            ),
            child: Text(
              "Please confirm you have a stable intent connection!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.darkGold,
                    fontSize: AppSizes.font_10,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),

        SizedBox(
          height: AppSizes.mp_v_4,
        ),

        Row(
          children: [
            ///BUILD CANCEL BUTTON
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.black,
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_2 * 0.8,
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
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: AppSizes.mp_w_2,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.gold,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_2 * 0.8,
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
                  context.read<GameStartBloc>().add(
                        StartGameEvent(
                          category: widget.gameInitialInfo.category,
                          amountToBet: widget.amountToBet,
                          initialLevelId:
                              widget.gameInitialInfo.levels.first.id,
                        ),
                      );
                },
                child: Text(
                  'Start',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
