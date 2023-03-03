import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_level_widget/game_group_level_widget_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_question_item/game_group_question_item_bloc.dart';
import 'package:quiz_bet/layer_data/models/enums.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/pages_util.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_controller/timer_controller.dart';

class ItemGroupGameQuestion extends StatefulWidget {
  const ItemGroupGameQuestion({
    Key? key,
    required this.gameQuestion,
    required this.questionNumber,
    required this.questionId,
    required this.groupQuizId,
  }) : super(key: key);

  final GameQuestion gameQuestion;
  final String questionNumber;
  final String questionId;
  final String groupQuizId;

  @override
  State<ItemGroupGameQuestion> createState() => _ItemGroupGameQuestionState();
}

class _ItemGroupGameQuestionState extends State<ItemGroupGameQuestion>
    with TickerProviderStateMixin {
  Choice? selectedChoice = null;

  late final TimerController timerController;

  double linerProgressPercentage = 1.0;
  QuestionTimeLeftStatus questionTimeLeftStatus = QuestionTimeLeftStatus.GREEN;

  @override
  void initState() {
    timerController = TimerController.seconds(widget.gameQuestion.maxTimeInSec);
    //timerController = TimerController.seconds(5);
    timerController.start();

    timerController.addListener(
      () {
        if (timerController.value.remaining < 1) {
          ///CHECK FOR ANSWER WHEN TIME RUNS OUT
          checkFoAnswer(false);
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameGroupQuestionItemBloc, GameGroupQuestionItemState>(
      listener: (context, state) {
        if (state is GameGroupQuestionSavedState) {
          context.read<GameGroupLevelWidgetBloc>().add(
                GameGroupLevelNextQuestionsEvent(isForfit: !state.isCorrect),
              );
        }
      },
      builder: (context, state) {
        if (state is GameGroupQuestionSavingState) {
          return Padding(
            padding: EdgeInsets.only(bottom: AppSizes.mp_v_2),
            child: Material(
              elevation: 2,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: AppCard(
                radius: AppSizes.radius_12,
                child: const AppLoadingWidget(),
              ),
            ),
          );
        }

        if (state is GameGroupQuestionSavingErrorState) {
          return Padding(
            padding: EdgeInsets.only(bottom: AppSizes.mp_v_2),
            child: Material(
              elevation: 2,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: AppCard(
                radius: AppSizes.radius_12,
                child: AppErrorWidget(onTryAgain: () {
                  context.read<GameGroupQuestionItemBloc>().add(
                        GameGroupQuestionCheckCorrectnessEvent(
                          selectedChoice: selectedChoice,
                          gameQuestionChoice: widget.gameQuestion.choice,
                          questionId: widget.questionId,
                          groupQuizId: widget.groupQuizId,
                          timeTaken: widget.gameQuestion.maxTimeInSec -
                              timerController.value.remaining,
                        ),
                      );
                }),
              ),
            ),
          );
        }

        return buildQuestionView(context);
      },
    );
  }

  Column buildQuestionView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AppCard(
            radius: AppSizes.radius_12,
            child: Material(
              elevation: 2,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///BUILD TOP LINER PROGRESS
                  buildTopProgress(context),

                  SizedBox(
                    height: AppSizes.mp_v_2,
                  ),

                  ///BUILD QUESTION
                  buildQuestion(context),

                  ///BUILD ANSWER
                  Expanded(
                    child: Center(
                      child: buildAnswersList(context),
                    ),
                  ),

                  // SizedBox(
                  //   height: AppSizes.mp_v_2,
                  // ),

                  ///BUILD ODD INFO
                  buildOddInfo(context),

                  SizedBox(
                    height: AppSizes.mp_v_4,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppSizes.mp_v_4),
        buildContinueButton(context),
        SizedBox(height: AppSizes.mp_v_4),
      ],
    );
  }

  Container buildContinueButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_14,
      ),
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
          ///CHECK FOR ANSWER WHEN CONTINUE IS CLICKED
          checkFoAnswer(true);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontSize: AppSizes.font_12,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              width: AppSizes.mp_w_2,
            ),
            Icon(
              FontAwesomeIcons.solidCircleChevronRight,
              size: AppSizes.icon_size_4,
              color: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }

  Column buildTopProgress(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.icon_size_4 * 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.radius_12),
            ),
            child: TimerControllerListener(
              controller: timerController,
              child: LinearProgressIndicator(
                value: linerProgressPercentage,
                valueColor: AlwaysStoppedAnimation<Color>(
                  PagesUtil.getQuestionCardProgressColor(
                    questionTimeLeftStatus,
                  ),
                ),
                backgroundColor: AppColors.lightGrey,
              ),
              listener: (BuildContext context, TimerValue value) {
                print("timerController => ${timerController.value.remaining}");

                setState(() {
                  linerProgressPercentage = ((value.remaining * 100) /
                          widget.gameQuestion.maxTimeInSec) /
                      100;

                  if (linerProgressPercentage > 0.6 &&
                      linerProgressPercentage < 1.0) {
                    questionTimeLeftStatus = QuestionTimeLeftStatus.GREEN;
                  } else if (linerProgressPercentage > 0.3 &&
                      linerProgressPercentage < 0.6) {
                    questionTimeLeftStatus = QuestionTimeLeftStatus.GOLD;
                  } else if (linerProgressPercentage < 0.3) {
                    questionTimeLeftStatus = QuestionTimeLeftStatus.RED;
                  }
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: AppSizes.mp_v_4,
        ),
        Padding(
          padding: EdgeInsets.only(left: AppSizes.mp_w_4),
          child: TimerControllerBuilder(
            controller: timerController,
            builder: (BuildContext context, TimerValue value, Widget? child) {
              return Text(
                PagesUtil.getDigitalTimeFormat(
                  Duration(seconds: value.remaining),
                ),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.bold,
                    ),
              );
            },
          ),
        ),
      ],
    );
  }

  buildQuestion(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
        //vertical: AppSizes.mp_v_2,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question ${widget.questionNumber}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_4,
              ),
              SizedBox(
                width: AppSizes.mp_w_10,
                child: Divider(
                  color: AppColors.lightGrey,
                  thickness: 3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          Text(
            widget.gameQuestion.question.nameAm,
            textAlign: TextAlign.start,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.completelyBlack,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  buildAnswersList(context) {
    return Wrap(
      spacing: AppSizes.mp_w_2,
      runSpacing: AppSizes.mp_w_2,
      children: buildAnswersListItems(context),
    );
  }

  Container buildAnswerPickerItem(
      Choice choice, String answerText, bool isSelected) {
    return Container(
      width: 40.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.darkBlue : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(
          AppSizes.radius_4,
        ),
      ),
      child: AppButtonFeedBack(
        onTap: () {
          setState(() {
            selectedChoice = choice;
          });

          FlutterBeep.playSysSound(iOSSoundIDs.KeyPressed3);
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.mp_w_4),
            child: Text(
              answerText,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.completelyBlack,
                    fontSize: AppSizes.font_10,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  buildOddInfo(context) {
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
          child: Text(
            "Win Up To\n1000,000 ETB",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkGold,
                  letterSpacing: 1.2,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }

  buildAnswersListItems(context) {
    final List<Widget> answerOptionList = [];

    for (var element in widget.gameQuestion.choice.choices) {
      answerOptionList.add(
        buildAnswerPickerItem(
          element,
          '${element.option.toUpperCase()}. ${element.value}',
          selectedChoice == null
              ? false
              : selectedChoice!.value == element.value,
        ),
      );
    }

    return answerOptionList;
  }

  void checkFoAnswer(bool isForButton) {
    if (isForButton) {
      if (selectedChoice == null) {
        AnimatedSnackBar.material(
          'Answer Not Selected',
          type: AnimatedSnackBarType.warning,
        ).show(context);
      } else {
        context.read<GameGroupQuestionItemBloc>().add(
              GameGroupQuestionCheckCorrectnessEvent(
                selectedChoice: selectedChoice,
                gameQuestionChoice: widget.gameQuestion.choice,
                questionId: widget.questionId,
                groupQuizId: widget.groupQuizId,
                timeTaken: widget.gameQuestion.maxTimeInSec -
                    timerController.value.remaining,
              ),
            );
      }
    } else {
      context.read<GameGroupQuestionItemBloc>().add(
            GameGroupQuestionCheckCorrectnessEvent(
              selectedChoice: selectedChoice,
              gameQuestionChoice: widget.gameQuestion.choice,
              questionId: widget.questionId,
              groupQuizId: widget.groupQuizId,
              timeTaken: widget.gameQuestion.maxTimeInSec -
                  timerController.value.remaining,
            ),
          );
    }
  }
}
