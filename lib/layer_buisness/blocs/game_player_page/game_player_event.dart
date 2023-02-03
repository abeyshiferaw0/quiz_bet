part of 'game_player_bloc.dart';

abstract class GamePlayerEvent extends Equatable {
  const GamePlayerEvent();
}

class GameStartedEvent extends GamePlayerEvent {
  final GameInfo gameInfo;
  final int amountToBet;
  final double vatPer;

  const GameStartedEvent(
      {required this.amountToBet,
      required this.vatPer,
      required this.gameInfo});

  @override
  List<Object?> get props => [
        gameInfo,
        amountToBet,
        gameInfo,
      ];
}

class GameNextLevelEventEvent extends GamePlayerEvent {
  const GameNextLevelEventEvent();

  @override
  List<Object?> get props => [];
}
