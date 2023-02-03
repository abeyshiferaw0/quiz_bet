import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_bet/layer_data/models/enums.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/pages_util.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_controller/timer_controller.dart';

class ItemGameQuizCard extends StatefulWidget {
  const ItemGameQuizCard(
      {Key? key,
      required this.gameQuestion,
      required this.questionNumber,
      required this.odd,
      required this.amountToBet,
      required this.onTimeEnd, required this.onAnswerPicked})
      : super(key: key);

  final int questionNumber;
  final GameQuestion gameQuestion;
  final double odd;
  final int amountToBet;
  final Function(GameQuestion gameQuestion,Choice? choice) onTimeEnd;
  final Function(GameQuestion gameQuestion,Choice choice) onAnswerPicked;

  @override
  State<ItemGameQuizCard> createState() => _ItemGameQuizCardState();
}

class _ItemGameQuizCardState extends State<ItemGameQuizCard> {
  int selectedAnswerIndex = -1;

  late final TimerController timerController;

  double linerProgressPercentage = 1.0;
  QuestionTimeLeftStatus questionTimeLeftStatus = QuestionTimeLeftStatus.GREEN;

  @override
  void initState() {
    //timerController = TimerController.seconds(widget.gameQuestion.maxTimeInSec);
    timerController = TimerController.seconds(5);
    timerController.start();

    timerController.addListener(() {
      if (timerController.value.remaining < 1) {
        if (selectedAnswerIndex != -1) {
          print("CHECK BUG => onTimeEnd 1");
          widget.onTimeEnd(
            widget.gameQuestion,widget.gameQuestion.choice.choices.elementAt(selectedAnswerIndex),
          );
        } else {
          print("CHECK BUG => onTimeEnd 2");
          widget.onTimeEnd(widget.gameQuestion,null);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppSizes.radius_12,
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
      Choice choice, int index, String answerText, bool isSelected) {
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
            selectedAnswerIndex = index;
          });

          print("CHECK BUG => onAnswerPicked");
          widget.onAnswerPicked(widget.gameQuestion,choice);

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
            "Winning odd\n${widget.amountToBet.toStringAsFixed(2)} ETB * ${widget.odd} = ${(widget.amountToBet * widget.odd).toStringAsFixed(2)} ETB",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkGold,
                  fontSize: AppSizes.font_10,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }

  buildAnswersListItems(context) {
    final List<Widget> answerOptionList = [];

    int i = 0;

    for (var element in widget.gameQuestion.choice.choices) {
      answerOptionList.add(
        buildAnswerPickerItem(
          element,
          i,
          '${element.option.toUpperCase()}. ${element.value}',
          selectedAnswerIndex == i,
        ),
      );

      i++;
    }

    return answerOptionList;
  }
}
