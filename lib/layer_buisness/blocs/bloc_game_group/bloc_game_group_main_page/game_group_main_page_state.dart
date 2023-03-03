part of 'game_group_main_page_bloc.dart';

abstract class GameGroupMainPageState extends Equatable {
  const GameGroupMainPageState();
}

class GameGroupMainPageInitial extends GameGroupMainPageState {
  @override
  List<Object> get props => [];
}

class GameGroupPlayLevelState extends GameGroupMainPageState {

  final  GameLevel gameLevel;


  GameGroupPlayLevelState({required this.gameLevel});

  @override
  List<Object> get props => [gameLevel];
}

class GameGroupPlayLevelDoneState extends GameGroupMainPageState {

  @override
  List<Object> get props => [];
}



