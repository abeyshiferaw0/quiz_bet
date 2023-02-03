import 'package:flutter/material.dart';
import 'package:quiz_bet/layer_data/models/enums.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/item_game_result_card.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/widgets/item_game_quiz_card.dart';
import 'package:quiz_bet/theme/app_colors.dart';

class PagesUtil {
  static getTotalOdd(List<GameLevel> levels) {
    double totalOdd = 0;
    for (var element in levels) {
      totalOdd = totalOdd + element.odd;
    }
    return totalOdd;
  }

  static int getIncrementedBid(String text) {
    int bidVal = 0;

    if (text == null || text.isEmpty) {
      bidVal = 1;
    } else {
      bidVal = int.parse(text);
      bidVal++;
    }

    return bidVal;
  }

  static int getDescrimentedBid(String text) {
    int bidVal = 0;

    if (text == null || text.isEmpty) {
      bidVal = 0;
    } else {
      bidVal = int.parse(text);

      if (bidVal < 1) {
        bidVal = bidVal;
      } else {
        bidVal--;
      }
    }

    return bidVal;
  }

  static getAmountToBe(String text) {
    if (text == null || text.isEmpty) {
      return 0;
    } else {
      return int.parse(text);
    }
  }

  static getGameLevelQuestionsCards(
      GameLevel gameLevel,
      int amountToBet,
      Function(GameQuestion gameQuestion, Choice? choice) onTimeEnd,
      Function(GameQuestion gameQuestion, Choice choice) onAnswerPicked) {
    List<Widget> cards = [];

    ///ADD QUESTIONS CARD
    for (var element in gameLevel.questions) {
      cards.add(
        ItemGameQuizCard(
          key: Key(element.id),
          questionNumber: gameLevel.questions.indexOf(element) + 1,
          gameQuestion: element,
          odd: gameLevel.odd,
          amountToBet: amountToBet,
          onTimeEnd: onTimeEnd,
          onAnswerPicked: onAnswerPicked,
        ),
      );
    }

    ///FINALLY ADD RESULT UI
    cards.add(const ItemGameResultCard());

    ///REVERSE FOR LIST TO BE DISPLAYED QUESTIONS FIRST
    cards = cards.reversed.toList();

    return cards;
  }

  static Color getQuestionCardProgressColor(
      QuestionTimeLeftStatus questionTimeLeftStatus) {
    if (questionTimeLeftStatus == QuestionTimeLeftStatus.GOLD) {
      return AppColors.gold;
    }
    if (questionTimeLeftStatus == QuestionTimeLeftStatus.RED) {
      return AppColors.red;
    }
    if (questionTimeLeftStatus == QuestionTimeLeftStatus.GREEN) {
      return AppColors.green;
    }
    return AppColors.gold;
  }

  static String getDigitalTimeFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
