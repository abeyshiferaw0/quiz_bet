import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_gmae_history_saver/game_history_saver_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class DialogLevelFailure extends StatefulWidget {
  const DialogLevelFailure({
    Key? key,
    required this.gameInfo,
    required this.gameLevel,
    required this.timeTaken,
    required this.choice,
    required this.gameQuestion,
  }) : super(key: key);

  final GameInfo gameInfo;
  final GameLevel gameLevel;
  final int timeTaken;
  final Choice choice;
  final GameQuestion gameQuestion;

  @override
  State<DialogLevelFailure> createState() => _DialogLevelFailureState();
}

class _DialogLevelFailureState extends State<DialogLevelFailure> {
  @override
  void initState() {
    context.read<GameHistorySaverBloc>().add(
          GameHistorySaverSaveForfitEvent(
            choice: widget.choice,
            timeTaken: widget.timeTaken,
            gameInfo: widget.gameInfo,
            gameLevel: widget.gameLevel,
            gameQuestion: widget.gameQuestion,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
            child: BlocBuilder<GameHistorySaverBloc, GameHistorySaverState>(
              builder: (context, state) {
                if (state is GameHistorySaverLoadingState) {
                  return const AppLoadingWidget();
                }

                if (state is GameHistorySaverLoadingErrorState) {
                  return AppErrorWidget(onTryAgain: (){
                    context.read<GameHistorySaverBloc>().add(
                      GameHistorySaverSaveForfitEvent(
                        choice: widget.choice,
                        timeTaken: widget.timeTaken,
                        gameInfo: widget.gameInfo,
                        gameLevel: widget.gameLevel,
                        gameQuestion: widget.gameQuestion,
                      ),
                    );
                  });
                }

                if (state is GameHistorySaverLoadedState) {
                  return buildLoadedView(context);
                }

               return SizedBox();
              },
            ),
          ),
        ],
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

        Lottie.asset(
          AppAssets.failureLottie,
          width: AppSizes.icon_size_12,
          fit: BoxFit.cover,
        ),

        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        ///BUILD DIALOG TITLE
        Text(
          "Level Failed",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.red,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.bold,
              ),
        ),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
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
                  'Continue',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkBlue,
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
