part of 'game_group_challange_create_bloc.dart';

abstract class GameGroupChallangeCreateState extends Equatable {
  const GameGroupChallangeCreateState();
}

class GameGroupChallangeCreateInitial extends GameGroupChallangeCreateState {
  @override
  List<Object> get props => [];
}

class GameGroupChallangeCreateLoadingState extends GameGroupChallangeCreateState {
  @override
  List<Object> get props => [];
}

class GameGroupChallangeCreateLoadingErrorState extends GameGroupChallangeCreateState {

  final String error;

  const GameGroupChallangeCreateLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameGroupChallangeCreateLoadedState extends GameGroupChallangeCreateState {

  final GameGroupInfo gameGroupInfo;

  const GameGroupChallangeCreateLoadedState({required this.gameGroupInfo});

  @override
  List<Object> get props => [gameGroupInfo];
}
