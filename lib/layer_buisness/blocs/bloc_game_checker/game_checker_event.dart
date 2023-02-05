part of 'game_checker_bloc.dart';

abstract class GameCheckerEvent extends Equatable {
  const GameCheckerEvent();
}

class StartLevelEvent extends GameCheckerEvent {
  final GameInfo gameInfo;
  final GameLevel gameLevel;


  const StartLevelEvent( {
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
  final Choice? choice;
  final int timeTaken;

  const CheckAnswerEvent( {
    required this.timeTaken,
    required this.gameLevel,
    required this.gameQuestion,
    required this.choice,
  });

  @override
  List<Object?> get props => [
    gameLevel,
        gameQuestion,
        choice,
    timeTaken,
      ];
}


class CheckAnswerShowNextLevelCountDownEvent extends GameCheckerEvent {

  final GameLevel gameLevel;
  final Choice? choice;
  final int timeTaken;

  const CheckAnswerShowNextLevelCountDownEvent({required this.gameLevel, this.choice, required this.timeTaken,});

  @override
  List<Object?> get props => [
    gameLevel,
    choice,
    timeTaken,
  ];
}
