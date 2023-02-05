import 'dart:math';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_checker/game_checker_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/game_player_page/game_player_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/dialog_level_failure.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/item_game_levels_complited.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/item_game_next_level_count_down.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/item_game_quiz_card.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/item_game_result_card.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/pages_util.dart';

class GamePlayerPage extends StatefulWidget {
  const GamePlayerPage(
      {Key? key,
      required this.gameInfo,
      required this.amountToBet,
      required this.vatPer})
      : super(key: key);

  final GameInfo gameInfo;
  final int amountToBet;
  final double vatPer;

  @override
  State<GamePlayerPage> createState() => _GamePlayerPageState();
}

class _GamePlayerPageState extends State<GamePlayerPage> {
  ///APP SWIPER CONTROLLER
  AppinioSwiperController appinioSwiperController = AppinioSwiperController();

  int curentQuesionIndex = 0;

  @override
  void initState() {
    ///START PLAYING INITIAL GAME LEVEL
    context.read<GamePlayerBloc>().add(
          GameStartedEvent(
            gameInfo: widget.gameInfo,
            amountToBet: widget.amountToBet,
            vatPer: widget.vatPer,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<GamePlayerBloc, GamePlayerState>(
          listener: (context, state) {
            if (state is GamePlayerPlayLevelState) {
              ////START PLAYING LEVEL
              context.read<GameCheckerBloc>().add(
                    StartLevelEvent(
                      gameInfo: state.gameInfo,
                      gameLevel: state.gameLevel,
                    ),
                  );
            }
          },
          builder: (context, state) {
            if (state is GamePlayerPlayLevelState) {
              return buildPlayGameLevelView(
                context,
                state.gameLevel,
                state.curentLevelIndex,
              );
            }

            if (state is GamePlayerLevelsDoneState) {
              return buildGameLevelComplitedView(context);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Column buildPlayGameLevelView(
      BuildContext context, GameLevel gameLevel, int curentLevelIndex) {
    return Column(
      children: [
        ///BUILD APP BAR
        buildAppBar(gameLevel, curentLevelIndex),

        ///BUILD QUESTIONS SLIDER
        buildQuestionsSlider(gameLevel),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        SizedBox(height: AppSizes.mp_v_4),
      ],
    );
  }

  Column buildGameLevelComplitedView(BuildContext context) {
    return Column(
      children: [
        ///BUILD APP BAR
        buildComplitedAppBar(),

        ///BUILD QUESTIONS SLIDER
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
            child: const ItemGameLevelsComplited(),
          ),
        ),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        SizedBox(height: AppSizes.mp_v_4),
      ],
    );
  }

  buildQuestionsSlider(GameLevel gameLevel) {
    return Expanded(
      child: BlocConsumer<GameCheckerBloc, GameCheckerState>(
        listener: (context, state) {
          if (state is GameCheckerUserForfitState) {
            showDialog<bool>(
              context: context,
              builder: (context) {
                return const DialogLevelFailure();
              },
            ).then((value) => Navigator.pop(context));
          }
        },
        builder: (context, state) {
          if (state is GameCheckerShowQuestionState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInCubic,
                switchOutCurve: Curves.easeOutCubic,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotate,
                    child: child,
                    builder: (BuildContext context, Widget? child) {
                      final angle = rotate.value;
                      return Transform(
                        transform: Matrix4.rotationY(angle),
                        child: child,
                        alignment: Alignment.center,
                      );
                    },
                  );
                },
                child: ItemGameQuizCard(
                  key: Key(state.gameQuestion.id),
                  gameQuestion: state.gameQuestion,
                  questionNumber: state.questionNumber,
                  amountToBet: widget.amountToBet,
                  gameLevel: state.gameLevel,
                ),
              ),
            );
          }
          if (state is GameCheckerShowNextLevelCountDownState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
              child: ItemGameNextLevelCountDown(
                amountToBet: widget.amountToBet,
                vatPer: widget.vatPer,
                gameInfo: state.gameInfo,
                gameLevel: gameLevel,
                nextLevel: state.nextLevel,
                timeTaken: state.timeTaken,
              ),
            );
          }
          if (state is GameCheckerNextLevelState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
              child: ItemGameResultCard(
                amountToBet: widget.amountToBet,
                vatPer: widget.vatPer,
                gameInfo: state.gameInfo,
                gameLevel: gameLevel,
                nextLevel: state.nextLevel,
                timeTaken: state.timeTaken,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );

    // return Expanded(
    //   child: CupertinoPageScaffold(
    //     child: AppinioSwiper(
    //       cards: PagesUtil.getGameLevelQuestionsCards(
    //         gameLevel,
    //         widget.amountToBet,
    //         // (GameQuestion gameQuestion, Choice? choice) {
    //         //   // ///SET USERS ANSWER
    //         //   // gameLevel.questions
    //         //   //     .firstWhere((element) => element.id == gameQuestion.id)
    //         //   //     .choice
    //         //   //     .usersAnswer = choice;
    //         //   //
    //         //   // ///WHEN QUESTION ABOUT TO SWIPE
    //         //   // ///CHECK IF ANSWER IS CORRECT
    //         //   // ///SWIPE IF CORRECT SHOW LEVEL FAILURE IF NOT
    //         //   // bool answerIsCorrect = true;
    //         //   // if (choice == null) {
    //         //   //   answerIsCorrect = false;
    //         //   // } else {
    //         //   //   if (gameQuestion.choice.correctOption != choice.option) {
    //         //   //     answerIsCorrect = false;
    //         //   //   }
    //         //   // }
    //         //   //
    //         //   //
    //         //   // print("answerIsCorrect =>> ${answerIsCorrect}");
    //         //   // if (answerIsCorrect) {
    //         //   //   ///SWIPE AS TIME HAS ENDED
    //         //   //  // swipeQuestions(gameLevel);
    //         //   // } else {
    //         //   //   showDialog<bool>(
    //         //   //     context: context,
    //         //   //     builder: (context) {
    //         //   //       return DialogLevelFailure();
    //         //   //     },
    //         //   //   ).then((value) => Navigator.pop(context));
    //         //   // }
    //         // },
    //         // (GameQuestion gameQuestion, Choice choice) {
    //         //   ///SET USERS ANSWER
    //         //   // gameLevel.questions
    //         //   //     .firstWhere((element) => element.id == gameQuestion.id)
    //         //   //     .choice
    //         //   //     .usersAnswer = choice;
    //         // },
    //       ),
    //       controller: appinioSwiperController,
    //       duration: const Duration(milliseconds: 600),
    //       padding: EdgeInsets.only(
    //         left: AppSizes.mp_w_4,
    //         right: AppSizes.mp_w_4,
    //         bottom: AppSizes.mp_v_4,
    //       ),
    //       isDisabled: true,
    //       onSwipe: (i, d) {
    //         curentQuesionIndex++;
    //       },
    //     ),
    //   ),
    // );
  }

  buildAppBar(GameLevel gameLevel, int curentLevelIndex) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        //horizontal: AppSizes.mp_w_4,
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
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameLevel.name.nameAm,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font_12,
                      ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 2,
                ),
                SizedBox(
                  height: AppSizes.icon_size_2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius_12),
                    ),
                    child: BlocBuilder<GameCheckerBloc, GameCheckerState>(
                      builder: (context, state) {
                        if (state is GameCheckerShowQuestionState) {
                          return LinearProgressIndicator(
                            value: ((state.questionNumber * 100) /
                                    state.gameLevel.questions.length) /
                                100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.green,
                            ),
                            backgroundColor: AppColors.lightGrey,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 3,
                ),
                BlocBuilder<GameCheckerBloc, GameCheckerState>(
                  builder: (context, state) {
                    if (state is GameCheckerShowQuestionState) {
                      return Text(
                        "Questions ${state.questionNumber}/${state.gameLevel.questions.length}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.gold,
                              fontSize: AppSizes.font_9,
                              fontWeight: FontWeight.w400,
                            ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          BouncingButton(
            child: Icon(
              FontAwesomeIcons.xmark,
              size: AppSizes.icon_size_6,
              color: AppColors.gold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: AppSizes.mp_w_1,
          ),
        ],
      ),
    );
  }

  buildComplitedAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        //horizontal: AppSizes.mp_w_4,
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
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Levels Complited",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font_12,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          BouncingButton(
            child: Icon(
              FontAwesomeIcons.xmark,
              size: AppSizes.icon_size_6,
              color: AppColors.gold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: AppSizes.mp_w_1,
          ),
        ],
      ),
    );
  }

  void swipeQuestions(gameLevel) {
    if (curentQuesionIndex <= (gameLevel.questions.length - 1)) {
      appinioSwiperController.swipeLeft();
    }
  }

  void checkQuesionForCorrectness() {}
}
