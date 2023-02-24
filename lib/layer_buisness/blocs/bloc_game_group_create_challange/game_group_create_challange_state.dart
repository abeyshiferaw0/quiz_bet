part of 'game_group_create_challange_bloc.dart';

abstract class GameGroupCreateChallangeState extends Equatable {
  const GameGroupCreateChallangeState();
}

class GameGroupCreateChallangeInitial extends GameGroupCreateChallangeState {
  @override
  List<Object> get props => [];
}

class GameGroupCreateChallangeLoadingState extends GameGroupCreateChallangeState {
  @override
  List<Object> get props => [];
}

class GameGroupCreateChallangeLoadingErrorState extends GameGroupCreateChallangeState {

  final String error;

  const GameGroupCreateChallangeLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameGroupCreateChallangeLoadedState extends GameGroupCreateChallangeState {

  final CreateChallangePageData createChallangePageData;

  const GameGroupCreateChallangeLoadedState({required this.createChallangePageData});

  @override
  List<Object> get props => [createChallangePageData];
}
