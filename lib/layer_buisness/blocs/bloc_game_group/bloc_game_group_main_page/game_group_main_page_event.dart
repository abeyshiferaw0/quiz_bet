part of 'game_group_main_page_bloc.dart';

abstract class GameGroupMainPageEvent extends Equatable {
  const GameGroupMainPageEvent();
}

class StartGroupGameLevel extends GameGroupMainPageEvent {
  @override
  List<Object?> get props => [];
}

class NextGroupGameLevel extends GameGroupMainPageEvent {
  @override
  List<Object?> get props => [];
}
