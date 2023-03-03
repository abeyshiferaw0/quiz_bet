part of 'game_group_forfit_winner_listner_subscription_bloc.dart';

abstract class GameGroupForfitWinnerListnerSubscriptionState   {
  const GameGroupForfitWinnerListnerSubscriptionState();
}

class GameGroupForfitWinnerListnerSubscriptionInitial extends GameGroupForfitWinnerListnerSubscriptionState {

}


class GameGroupPlayerWinnerState extends GameGroupForfitWinnerListnerSubscriptionState {

  final String winningPrize;
  final String numberOfPlayers;
  final String placedBet;
  final String vatPer;
  final String vatDeducted;


  GameGroupPlayerWinnerState(
      {required this.winningPrize, required this.numberOfPlayers, required this.placedBet, required this.vatPer,required this.vatDeducted,});


}

class GameGroupForfitShowNotificationState extends GameGroupForfitWinnerListnerSubscriptionState {

  final List<GameGroupActivePlayer> showForfitNotifyList ;

  GameGroupForfitShowNotificationState({required this.showForfitNotifyList});

}
