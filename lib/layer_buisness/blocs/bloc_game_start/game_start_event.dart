part of 'game_start_bloc.dart';

abstract class GameStartEvent extends Equatable {
  const GameStartEvent();
}


 class StartGameEvent extends GameStartEvent {

   final Category category;
   final int amountToBet;
   final String initialLevelId;

  const
  StartGameEvent( {required this.amountToBet,required this.category,required this.initialLevelId});

  @override
  List<Object?> get props => [category,amountToBet,initialLevelId];

}
