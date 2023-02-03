part of 'game_start_bloc.dart';

abstract class GameStartEvent extends Equatable {
  const GameStartEvent();
}


 class StartGameEvent extends GameStartEvent {

   final String categoryId;

  const StartGameEvent({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];

}
