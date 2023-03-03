import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_question_item_event.dart';
part 'game_group_question_item_state.dart';

class GameGroupQuestionItemBloc
    extends Bloc<GameGroupQuestionItemEvent, GameGroupQuestionItemState> {
  final GameQuestion gameQuestion;
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;

  GameGroupQuestionItemBloc(
      {required this.gamePageRepository,
      required this.authPageRepository,
      required this.gameQuestion})
      : super(GameGroupQuestionItemInitial()) {
    on<GameGroupQuestionItemEvent>((event, emit) async {
      if (event is GameGroupQuestionCheckCorrectnessEvent) {
        ///EMIT LOADING
        emit(GameGroupQuestionSavingState());

        try {
          //GET USER ID
          String userId = await authPageRepository.getUserId();

          ///CHECK FOR ANSWER CORRECTNESS
          bool isAnswerCorrectOne =
              isAnswerCorrect(event.selectedChoice, event.gameQuestionChoice);

          ///SAVE GAME HISTORY
          await gamePageRepository.saveGroupGameHistory(
            userId: userId,
            answer: event.selectedChoice == null
                ? ''
                : event.selectedChoice!.option,
            isCorrect: isAnswerCorrectOne,
            questionId: event.questionId,
            groupQuizId: event.groupQuizId,
            timeTaken: event.timeTaken,
          );

          ///EMIT SAVED STATE
          emit(
            GameGroupQuestionSavedState(
              isCorrect: isAnswerCorrectOne,
            ),
          );
        } catch (e) {
          emit(
            GameGroupQuestionSavingErrorState(error: e.toString()),
          );
        }
      }
    });
  }

  bool isAnswerCorrect(
      Choice? selectedChoice, GameQuestionChoice gameQuestionChoice) {
    bool isAnswerCorrectOne = true;

    if (selectedChoice == null) {
      return false;
    }

    if (selectedChoice.option != gameQuestionChoice.correctOption) {
      return false;
    }

    return isAnswerCorrectOne;
  }
}
