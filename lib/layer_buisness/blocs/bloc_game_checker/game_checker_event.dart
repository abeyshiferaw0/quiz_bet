part of 'game_checker_bloc.dart';

abstract class GameCheckerEvent extends Equatable {
  const GameCheckerEvent();
}

class StartLevelEvent extends GameCheckerEvent {
  final GameInfo gameInfo;
  final GameLevel gameLevel;

  const StartLevelEvent({
    required this.gameInfo,
    required this.gameLevel,
  });

  @override
  List<Object?> get props => [
        gameInfo,
        gameLevel,
      ];
}

class CheckAnswerEvent extends GameCheckerEvent {
  final GameLevel gameLevel;
  final GameQuestion gameQuestion;
  final Choice choice;

  const CheckAnswerEvent({
    required this.gameLevel,
    required this.gameQuestion,
    required this.choice,
  });

  @override
  List<Object?> get props => [
    gameLevel,
        gameQuestion,
        choice,
      ];
}
