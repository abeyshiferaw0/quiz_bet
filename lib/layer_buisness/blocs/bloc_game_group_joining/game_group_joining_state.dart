part of 'game_group_joining_bloc.dart';

abstract class GameGroupJoiningState extends Equatable {
  const GameGroupJoiningState();
}

class GameGroupJoiningInitial extends GameGroupJoiningState {
  @override
  List<Object> get props => [];
}

class GameGroupJoiningLoadingState extends GameGroupJoiningState {
  @override
  List<Object> get props => [];
}

class GameGroupJoiningLoadingErrorState extends GameGroupJoiningState {

  final String error;

  const GameGroupJoiningLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameGroupJoiningLoadedState extends GameGroupJoiningState {

  final GameGroupInfo gameGroupInfo;

  GameGroupJoiningLoadedState({required this.gameGroupInfo});

  @override
  List<Object> get props => [gameGroupInfo];
}
