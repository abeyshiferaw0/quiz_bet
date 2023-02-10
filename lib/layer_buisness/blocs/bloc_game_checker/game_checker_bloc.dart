import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

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

        emit(
          GameCheckerShowQuestionState(
            gameQuestion: event.gameLevel.questions.first,
            questionNumber: 1,
            gameLevel: event.gameLevel,
          ),
        );
      }

      if (event is CheckAnswerEvent) {
        ///SET USERS ANSWER
        currentGameLevel.questions
            .firstWhere((element) => element.id == event.gameQuestion.id)
            .choice
            .usersAnswer = event.choice;

        if (isAnswerCorrect(event.gameQuestion, event.choice)) {
          if (isLevelLastQuestion(event.gameLevel, event.gameQuestion)) {
            ///TODO
            ///SEND SERVER GAME HISTORY DATA

            emit(
              GameCheckerNextLevelState(
                gameLevel: currentGameLevel,
                nextLevel: gameInfo.levels
                    .elementAt(gameInfo.levels.indexOf(currentGameLevel)),
                gameInfo: gameInfo,
                timeTaken: event.timeTaken,
              ),
            );
          } else {
            int index = event.gameLevel.questions.indexOf(event.gameQuestion);
            emit(
              GameCheckerShowQuestionState(
                gameQuestion: event.gameLevel.questions.elementAt(index + 1),
                questionNumber: index + 2,
                gameLevel: event.gameLevel,
              ),
            );
          }
        } else {
          emit(GameCheckerUserForfitState());
        }
      }

      if (event is CheckAnswerShowNextLevelCountDownEvent) {
        emit(
          GameCheckerShowNextLevelCountDownState(
            gameLevel: event.gameLevel,
            nextLevel: gameInfo.levels.elementAt(
              gameInfo.levels.indexOf(currentGameLevel),
            ),
            gameInfo: gameInfo,
            timeTaken: event.timeTaken,
          ),
        );
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

  isAnswerCorrect(GameQuestion gameQuestion, Choice? choice) {
    if (choice == null) return false;
    if (gameQuestion.choice.correctOption == choice.option) {
      return true;
    }
    return false;
  }
}
