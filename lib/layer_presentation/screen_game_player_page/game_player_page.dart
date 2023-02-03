import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_buisness/blocs/game_player_page/game_player_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/dialog_level_failure.dart';
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
        child: BlocBuilder<GamePlayerBloc, GamePlayerState>(
          builder: (context, state) {
            if (state is GamePlayerPlayLevelState) {
              return buildPlayGameLevelView(context, state.gameLevel);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Column buildPlayGameLevelView(BuildContext context, GameLevel gameLevel) {
    return Column(
      children: [
        ///BUILD APP BAR
        buildAppBar(gameLevel),

        ///BUILD QUESTIONS SLIDER
        buildQuestionsSlider(gameLevel),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        ///BUILD CONTINUE BUTTON
        buildContinueButton(context, gameLevel),

        SizedBox(height: AppSizes.mp_v_4),
      ],
    );
  }

  Container buildContinueButton(BuildContext context, GameLevel gameLevel) {
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
            ///SWIPE AS TIME HAS ENDED
            swipeQuestions(gameLevel);
          // ///WHEN QUESTION ABOUT TO SWIPE
          // ///CHECK IF ANSWER IS CORRECT
          // ///SWIPE IF CORRECT SHOW LEVEL FAILURE IF NOT
          // bool answerIsCorrect  = true;
          // if(choice==null){
          //   answerIsCorrect=false;
          // }else{
          //   if(gameQuestion.choice.correctOption  != choice.option){
          //     answerIsCorrect=false;
          //   }
          // }
          //
          // if(answerIsCorrect){
          //   ///SWIPE AS TIME HAS ENDED
          //   swipeQuestions(gameLevel);
          // }else{
          //   showDialog<bool>(
          //     context: context,
          //     builder: (context) {
          //       return  DialogLevelFailure(
          //       );
          //     },
          //   );
          // }
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

  Expanded buildQuestionsSlider(GameLevel gameLevel) {
    return Expanded(
      child: CupertinoPageScaffold(
        child: AppinioSwiper(
          cards: PagesUtil.getGameLevelQuestionsCards(
            gameLevel,
            widget.amountToBet,
            (GameQuestion gameQuestion, Choice? choice) {
              ///SET USERS ANSWER
              gameLevel.questions
                  .firstWhere((element) => element.id == gameQuestion.id)
                  .choice
                  .usersAnswer = choice;

              ///WHEN QUESTION ABOUT TO SWIPE
              ///CHECK IF ANSWER IS CORRECT
              ///SWIPE IF CORRECT SHOW LEVEL FAILURE IF NOT
              bool answerIsCorrect = true;
              if (choice == null) {
                answerIsCorrect = false;
              } else {
                if (gameQuestion.choice.correctOption != choice.option) {
                  answerIsCorrect = false;
                }
              }


              print("answerIsCorrect =>> ${answerIsCorrect}");
              if (answerIsCorrect) {
                ///SWIPE AS TIME HAS ENDED
               // swipeQuestions(gameLevel);
              } else {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return DialogLevelFailure();
                  },
                ).then((value) => Navigator.pop(context));
              }
            },
            (GameQuestion gameQuestion, Choice choice) {
              ///SET USERS ANSWER
              gameLevel.questions
                  .firstWhere((element) => element.id == gameQuestion.id)
                  .choice
                  .usersAnswer = choice;
            },
          ),
          controller: appinioSwiperController,
          duration: const Duration(milliseconds: 600),
          padding: EdgeInsets.only(
            left: AppSizes.mp_w_4,
            right: AppSizes.mp_w_4,
            bottom: AppSizes.mp_v_4,
          ),
          isDisabled: true,
          onSwipe: (i, d) {
            curentQuesionIndex++;
          },
        ),
      ),
    );
  }

  buildAppBar(GameLevel gameLevel) {
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
                    child: LinearProgressIndicator(
                      value: 0.7,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.green,
                      ),
                      backgroundColor: AppColors.lightGrey,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 3,
                ),
                Text(
                  "Questions 0000/${gameLevel.questions.length}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontSize: AppSizes.font_9,
                        fontWeight: FontWeight.w400,
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
