part of 'game_checker_bloc.dart';

abstract class GameCheckerState extends Equatable {
  const GameCheckerState();
}

class GameCheckerInitial extends GameCheckerState {
  @override
  List<Object> get props => [];
}

class GameCheckerGoToNextPageState extends GameCheckerState {
  @override
  List<Object> get props => [];
}

class GameCheckerLevelForfeitState extends GameCheckerState {
  @override
  List<Object> get props => [];
}

class GameCheckerLevelEndState extends GameCheckerState {
  @override
  List<Object> get props => [];
}
