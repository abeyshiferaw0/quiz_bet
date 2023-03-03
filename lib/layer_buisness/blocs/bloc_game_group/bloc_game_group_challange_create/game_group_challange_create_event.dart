part of 'game_group_challange_create_bloc.dart';

abstract class GameGroupChallangeCreateEvent extends Equatable {
  const GameGroupChallangeCreateEvent();
}

class GameGroupCreateChallangeeEvent extends GameGroupChallangeCreateEvent {
  const GameGroupCreateChallangeeEvent(
      {required this.amountPerPerson,
      required this.categoryId,
      required this.levelId});

  final String amountPerPerson;
  final String categoryId;
  final String levelId;

  @override
  List<Object?> get props => [
        amountPerPerson,
        categoryId,
        levelId,
      ];
}
