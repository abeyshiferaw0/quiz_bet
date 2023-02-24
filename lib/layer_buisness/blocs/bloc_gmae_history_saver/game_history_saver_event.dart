part of 'game_history_saver_bloc.dart';

abstract class GameHistorySaverEvent extends Equatable {
  const GameHistorySaverEvent();
}

class GameHistorySaverSaveEvent extends GameHistorySaverEvent {
  final GameInfo gameInfo;
  final GameLevel gameLevel;
  final int timeTaken;

  const GameHistorySaverSaveEvent(
      {required this.timeTaken, required this.gameInfo, required this.gameLevel});

  @override
  List<Object?> get props => [
        gameInfo,
    timeTaken,
        gameLevel,
      ];
}

class GameHistorySaverSaveForfitEvent extends GameHistorySaverEvent {
  final GameInfo gameInfo;
  final GameLevel gameLevel;
  final int timeTaken;
  final Choice choice;
  final GameQuestion gameQuestion;

  const GameHistorySaverSaveForfitEvent(
      {required this.choice,required this.timeTaken, required this.gameInfo, required this.gameLevel,required this.gameQuestion,});

  @override
  List<Object?> get props => [
    gameInfo,
    timeTaken,
    gameLevel,
    choice,gameQuestion,
  ];
}
