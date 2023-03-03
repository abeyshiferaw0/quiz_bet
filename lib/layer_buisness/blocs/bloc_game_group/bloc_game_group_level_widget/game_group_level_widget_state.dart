part of 'game_group_level_widget_bloc.dart';

abstract class GameGroupLevelWidgetState extends Equatable {
  const GameGroupLevelWidgetState();
}

class GameGroupLevelWidgetInitial extends GameGroupLevelWidgetState {
  @override
  List<Object> get props => [];
}

class GameGroupAskQuesetionState extends GameGroupLevelWidgetState {

  final GameQuestion gameQuestion;
  final String questionNumber;

  GameGroupAskQuesetionState({required this.questionNumber,required this.gameQuestion});

  @override
  List<Object> get props => [gameQuestion,questionNumber];
}

class GameGroupQuesetionsDoneState extends GameGroupLevelWidgetState {


  @override
  List<Object> get props => [];
}

class GameGroupQuesetionsPlayerForfitState extends GameGroupLevelWidgetState {

  @override
  List<Object> get props => [];
}



