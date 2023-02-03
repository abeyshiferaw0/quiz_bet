part of 'game_player_bloc.dart';

abstract class GamePlayerState extends Equatable {
  const GamePlayerState();
}

class GamePlayerInitial extends GamePlayerState {
  @override
  List<Object> get props => [];
}


class GamePlayerPlayLevelState extends GamePlayerState {

  final GameLevel gameLevel;

  const GamePlayerPlayLevelState({required this.gameLevel});

  @override
  List<Object> get props => [gameLevel];
}
