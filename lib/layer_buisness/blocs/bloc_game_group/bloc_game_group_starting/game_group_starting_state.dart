part of 'game_group_starting_bloc.dart';

abstract class GameGroupStartingState extends Equatable {
  const GameGroupStartingState();
}

class GameGroupStartingInitial extends GameGroupStartingState {
  @override
  List<Object> get props => [];
}

class GameGroupStartingLoadingState extends GameGroupStartingState {
  @override
  List<Object> get props => [];
}

class GameGroupStartingLoadingErrorState extends GameGroupStartingState {

  final String error;

  GameGroupStartingLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameGroupStartingLoadedState extends GameGroupStartingState {
  @override
  List<Object> get props => [];
}
