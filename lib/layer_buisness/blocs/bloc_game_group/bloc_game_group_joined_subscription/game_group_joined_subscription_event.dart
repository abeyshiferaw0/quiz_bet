part of 'game_group_joined_subscription_bloc.dart';

abstract class GameGroupJoinedSubscriptionEvent extends Equatable {
  const GameGroupJoinedSubscriptionEvent();
}


class StartGameGroupJoinedEvent extends GameGroupJoinedSubscriptionEvent {
  const StartGameGroupJoinedEvent();

  @override
  List<Object?> get props => [];
}



