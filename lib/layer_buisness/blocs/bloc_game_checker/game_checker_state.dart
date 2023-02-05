part of 'game_checker_bloc.dart';

abstract class GameCheckerState extends Equatable {
  const GameCheckerState();
}

class GameCheckerInitial extends GameCheckerState {
  @override
  List<Object> get props => [];
}

class GameCheckerShowQuestionState extends GameCheckerState {
  final GameQuestion gameQuestion;
  final int questionNumber;
  final GameLevel gameLevel;

  const GameCheckerShowQuestionState({
    required this.gameQuestion,
    required this.questionNumber,
    required this.gameLevel,
  });

  @override
  List<Object> get props => [
        gameQuestion,
        questionNumber,
        gameLevel,
      ];
}

class GameCheckerNextLevelState extends GameCheckerState {

  final GameLevel gameLevel;
  final GameLevel nextLevel;
  final GameInfo gameInfo;
  final int timeTaken;

  const GameCheckerNextLevelState( {required this.timeTaken,required this.gameInfo, required this.gameLevel, required this.nextLevel});

  @override
  List<Object> get props => [gameLevel,nextLevel,gameInfo,timeTaken];
}

class GameCheckerUserForfitState extends GameCheckerState {
  @override
  List<Object> get props => [];
}


class GameCheckerShowNextLevelCountDownState extends GameCheckerState {

  final GameLevel gameLevel;
  final GameLevel nextLevel;
  final GameInfo gameInfo;
  final int timeTaken;

  const GameCheckerShowNextLevelCountDownState(
      {required this.gameLevel, required this.nextLevel, required this.gameInfo, required this.timeTaken});

  @override
  List<Object> get props => [
    gameLevel,
    nextLevel,
    gameInfo,
    timeTaken,
  ];
}