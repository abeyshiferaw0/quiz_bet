part of 'game_get_info_bloc.dart';

abstract class GameGetInfoEvent extends Equatable {
  const GameGetInfoEvent();
}



class GetInfoEvent extends GameGetInfoEvent {

  final String categoryId;

  const GetInfoEvent({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];

}