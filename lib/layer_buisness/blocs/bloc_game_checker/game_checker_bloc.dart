import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';

part 'game_checker_event.dart';
part 'game_checker_state.dart';

class GameCheckerBloc extends Bloc<GameCheckerEvent, GameCheckerState> {
  final log = Logger();

  late GameInfo gameInfo;
  late GameLevel currentGameLevel;

  GameCheckerBloc() : super(GameCheckerInitial()) {
    on<GameCheckerEvent>((event, emit) {
      if (event is StartLevelEvent) {
        ///ASSIGN STARTED LEVEL
        gameInfo = event.gameInfo;
        currentGameLevel = event.gameLevel;
      }

      if (event is CheckAnswerEvent) {
        if (isLevelLastQuestion(event.gameLevel, event.gameQuestion)) {
          log.i("isLevelLastQuestion => TRUE ${event.gameLevel.name.nameAm}");
        } else {
          log.i("isLevelLastQuestion => FALSE ${event.gameLevel.name.nameAm}");
        }
      }
    });
  }

  isLevelLastQuestion(GameLevel gameLevel, GameQuestion gameQuestion) {
    int index = gameLevel.questions.indexOf(gameQuestion);

    if ((gameLevel.questions.length - 1) == index) {
      return true;
    } else {
      return false;
    }
  }

  isLevelLastEnd(GameLevel gameLevel, GameQuestion gameQuestion) {}

  isAnswerCorrect(GameLevel gameLevel, GameQuestion gameQuestion) {}
}
