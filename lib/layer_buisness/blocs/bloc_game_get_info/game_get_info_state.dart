part of 'game_get_info_bloc.dart';

abstract class GameGetInfoState extends Equatable {
  const GameGetInfoState();
}

class GameGetInfoInitial extends GameGetInfoState {
  @override
  List<Object> get props => [];
}


class GameGetInfoLoadingState extends GameGetInfoState {
  @override
  List<Object> get props => [];
}


class GameGetInfoLoadingErrorState extends GameGetInfoState {

  final String error;

  const GameGetInfoLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}


class GameGetInfoLoadedState extends GameGetInfoState {

  final GameInitialInfo gameInitialInfo;

  const GameGetInfoLoadedState({required this.gameInitialInfo});

  @override
  List<Object> get props => [gameInitialInfo];
}
