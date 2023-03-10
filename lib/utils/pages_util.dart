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

  static bool isUUID ( uuid ) {
    RegExp hexColor = RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$');
    return hexColor.hasMatch(uuid);
  }
}
