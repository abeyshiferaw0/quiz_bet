part of 'game_group_joined_subscription_bloc.dart';

abstract class GameGroupJoinedSubscriptionState  {
  const GameGroupJoinedSubscriptionState();
}

class GameGroupJoinedSubscriptionInitial extends GameGroupJoinedSubscriptionState {
  @override
  List<Object> get props => [];
}

class GameGroupJoinedSubState extends GameGroupJoinedSubscriptionState {

  final List<GameGroupJoinedSubscription> gameGroupJoinedSubscriptions;

  GameGroupJoinedSubState({required this.gameGroupJoinedSubscriptions});

  @override
  List<Object> get props => [];
}
