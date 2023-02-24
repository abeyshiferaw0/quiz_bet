part of 'game_group_create_challange_bloc.dart';

abstract class GameGroupCreateChallangeEvent extends Equatable {
  const GameGroupCreateChallangeEvent();
}


class FetchInitialInfo extends GameGroupCreateChallangeEvent {
  const FetchInitialInfo();

  @override
  List<Object?> get props => [];
}
