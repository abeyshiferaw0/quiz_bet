part of 'game_player_bloc.dart';

abstract class GamePlayerState extends Equatable {
  const GamePlayerState();
}

class GamePlayerInitial extends GamePlayerState {
  @override
  List<Object> get props => [];
}


class GamePlayerPlayLevelState extends GamePlayerState {

  final GameInfo gameInfo;
  final GameLevel gameLevel;
  final int curentLevelIndex;

  const GamePlayerPlayLevelState({required this.curentLevelIndex, required this.gameInfo, required this.gameLevel});

  @override
  List<Object> get props => [curentLevelIndex,gameInfo,gameLevel];
}


class GamePlayerLevelsDoneState extends GamePlayerState {

  const GamePlayerLevelsDoneState();

  @override
  List<Object> get props => [];
}


class GamePlayerLevelUpdatingState extends GamePlayerState {

  const GamePlayerLevelUpdatingState();

  @override
  List<Object> get props => [];
}

class GamePlayerLevelUpdatingErrorState extends GamePlayerState {

 final String error;
 final GameLevel level;

  const GamePlayerLevelUpdatingErrorState( {required this.level,required this.error});

  @override
  List<Object> get props => [error,level];
}