part of 'game_group_started_listner_subscription_bloc.dart';

abstract class GameGroupStartedListnerSubscriptionEvent extends Equatable {
  const GameGroupStartedListnerSubscriptionEvent();
}
class StartGameGroupStartedListnerEvent extends GameGroupStartedListnerSubscriptionEvent {
  const StartGameGroupStartedListnerEvent();

  @override
  List<Object?> get props => [];
}
