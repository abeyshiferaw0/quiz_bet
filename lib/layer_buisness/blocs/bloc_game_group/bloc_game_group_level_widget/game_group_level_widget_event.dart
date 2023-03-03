part of 'game_group_level_widget_bloc.dart';

abstract class GameGroupLevelWidgetEvent extends Equatable {
  const GameGroupLevelWidgetEvent();
}

class GameGroupLevelStartQuestionsEvent extends GameGroupLevelWidgetEvent {

  @override
  List<Object?> get props => [];

}

class GameGroupLevelNextQuestionsEvent extends GameGroupLevelWidgetEvent {

  final bool isForfit;

  GameGroupLevelNextQuestionsEvent({required this.isForfit});

  @override
  List<Object?> get props => [isForfit];

}
