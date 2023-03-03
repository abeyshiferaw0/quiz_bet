import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';

part 'game_group_level_widget_event.dart';
part 'game_group_level_widget_state.dart';

class GameGroupLevelWidgetBloc
    extends Bloc<GameGroupLevelWidgetEvent, GameGroupLevelWidgetState> {
  int currentQuestionIndex = 0;
  final GameLevel gameLevel;

  GameGroupLevelWidgetBloc({required this.gameLevel})
      : super(GameGroupLevelWidgetInitial()) {

    print("BLOC => currentQuestionIndex => ${currentQuestionIndex}");

    on<GameGroupLevelWidgetEvent>((event, emit) async {
      if (event is GameGroupLevelStartQuestionsEvent) {
        ///START ASKING FIRST QUESTIONS
        GameQuestion currentQuestion =
            gameLevel.questions.elementAt(currentQuestionIndex);

        emit(
          GameGroupAskQuesetionState(
              gameQuestion: currentQuestion,
              questionNumber: '${currentQuestionIndex + 1}'),
        );
      }

      if (event is GameGroupLevelNextQuestionsEvent) {
        if (event.isForfit) {

          emit(GameGroupQuesetionsPlayerForfitState());
        } else {
          ///CHECK IF LAST QUESTION IS LAST ONE
          if ((gameLevel.questions.length - 1) == currentQuestionIndex) {
            ///QUESTIONS DONE
            emit(GameGroupQuesetionsDoneState());
          } else {
            //GO TO NEXT QUESTION
            ///INCREMENT CURRENT QUESTION
            currentQuestionIndex++;
            GameQuestion currentQuestion =
                gameLevel.questions.elementAt(currentQuestionIndex);

            emit(
              GameGroupAskQuesetionState(
                  gameQuestion: currentQuestion,
                  questionNumber: '${currentQuestionIndex + 1}'),
            );
          }
        }
      }
    });
  }
}
