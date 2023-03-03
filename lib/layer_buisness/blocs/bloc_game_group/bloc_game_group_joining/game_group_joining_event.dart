part of 'game_group_joining_bloc.dart';

abstract class GameGroupJoiningEvent extends Equatable {
  const GameGroupJoiningEvent();
}

class JoinGameGroupEvent extends GameGroupJoiningEvent {

  final String groupQuizId;
  final String categoryId;

  const JoinGameGroupEvent({required this.groupQuizId,required this.categoryId});

  @override
  List<Object?> get props => [groupQuizId,categoryId];

}
