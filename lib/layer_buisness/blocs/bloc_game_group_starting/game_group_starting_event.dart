part of 'game_group_starting_bloc.dart';

abstract class GameGroupStartingEvent extends Equatable {
  const GameGroupStartingEvent();
}


class StartGroupGameEvent extends GameGroupStartingEvent {

  final GameGroupInfo gameGroupInfo;

  const StartGroupGameEvent({required this.gameGroupInfo});

  @override
  List<Object?> get props => [gameGroupInfo];
}