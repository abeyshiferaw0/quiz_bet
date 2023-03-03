part of 'game_group_question_item_bloc.dart';

abstract class GameGroupQuestionItemEvent extends Equatable {
  const GameGroupQuestionItemEvent();
}

class GameGroupQuestionCheckCorrectnessEvent extends GameGroupQuestionItemEvent {

   final GameQuestionChoice gameQuestionChoice;
   final Choice? selectedChoice;

   final String questionId;
   final String groupQuizId;
   final int timeTaken;


  GameGroupQuestionCheckCorrectnessEvent( {required this.questionId, required this.groupQuizId, required this.timeTaken,required this.gameQuestionChoice,required this.selectedChoice,});

  @override
  List<Object?> get props => [
    gameQuestionChoice,
    selectedChoice,
    questionId,
    groupQuizId,
    timeTaken,
  ];
}
