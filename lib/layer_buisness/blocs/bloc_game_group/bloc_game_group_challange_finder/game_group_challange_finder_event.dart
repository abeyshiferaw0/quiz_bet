part of 'game_group_challange_finder_bloc.dart';

abstract class GameGroupChallangeFinderEvent extends Equatable {
  const GameGroupChallangeFinderEvent();
}

class FindeGameGroupChallangeEvent extends GameGroupChallangeFinderEvent {
  const FindeGameGroupChallangeEvent({required this.groupQuizId});

  final String groupQuizId;



  @override
  List<Object?> get props => [groupQuizId];
}
