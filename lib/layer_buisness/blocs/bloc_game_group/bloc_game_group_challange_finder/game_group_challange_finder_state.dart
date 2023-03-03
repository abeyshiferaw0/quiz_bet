part of 'game_group_challange_finder_bloc.dart';

abstract class GameGroupChallangeFinderState extends Equatable {
  const GameGroupChallangeFinderState();
}

class GameGroupChallangeFinderInitial extends GameGroupChallangeFinderState {
  @override
  List<Object> get props => [];
}

class GameGroupChallangeFinderLoadingState extends GameGroupChallangeFinderState {


  @override
  List<Object> get props => [];
}

class GameGroupChallangeFinderLoadingErrorState extends GameGroupChallangeFinderState {

  final String error;

  GameGroupChallangeFinderLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GameGroupChallangeFinderLoadedState extends GameGroupChallangeFinderState {
  final FindGroupChallangePageData findGroupChallangePageData;

  const GameGroupChallangeFinderLoadedState({required this.findGroupChallangePageData});

  @override
  List<Object> get props => [findGroupChallangePageData];
}
