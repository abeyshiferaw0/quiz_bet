part of 'game_start_bloc.dart';

abstract class GameStartState extends Equatable {
  const GameStartState();
}

class GameStartInitial extends GameStartState {
  @override
  List<Object> get props => [];
}


class GameStartLoading extends GameStartState {
  @override
  List<Object> get props => [];
}


class GameStartLoadingError extends GameStartState {

  final String error;

  const GameStartLoadingError({required this.error});

  @override
  List<Object> get props => [error];
}


class GameStartLoaded extends GameStartState {

  final GameInfo gameInfo;

  const GameStartLoaded({required this.gameInfo});

  @override
  List<Object> get props => [gameInfo];
}
