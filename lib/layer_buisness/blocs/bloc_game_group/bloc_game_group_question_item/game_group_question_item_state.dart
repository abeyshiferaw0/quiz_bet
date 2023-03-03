part of 'game_group_question_item_bloc.dart';

abstract class GameGroupQuestionItemState extends Equatable {
  const GameGroupQuestionItemState();
}

class GameGroupQuestionItemInitial extends GameGroupQuestionItemState {
  @override
  List<Object> get props => [];
}

class GameGroupQuestionSavingState extends GameGroupQuestionItemState {
  @override
  List<Object> get props => [];
}

class GameGroupQuestionSavingErrorState extends GameGroupQuestionItemState {

  final String error;

  const GameGroupQuestionSavingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameGroupQuestionSavedState extends GameGroupQuestionItemState {

final bool isCorrect;

  GameGroupQuestionSavedState({required this.isCorrect});

  @override
  List<Object> get props => [isCorrect];
}
