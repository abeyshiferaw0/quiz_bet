part of 'game_history_saver_bloc.dart';

abstract class GameHistorySaverState extends Equatable {
  const GameHistorySaverState();
}

class GameHistorySaverInitial extends GameHistorySaverState {
  @override
  List<Object> get props => [];
}


class GameHistorySaverLoadingState extends GameHistorySaverState {
  @override
  List<Object> get props => [];
}

class GameHistorySaverLoadingErrorState extends GameHistorySaverState {
  final String error;

  const GameHistorySaverLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameHistorySaverLoadedState extends GameHistorySaverState {

  @override
  List<Object> get props => [];
}