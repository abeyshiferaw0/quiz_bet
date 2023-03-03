import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_group_active_player.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_forfit_winner_listner_subscription_event.dart';

part 'game_group_forfit_winner_listner_subscription_state.dart';

class GameGroupForfeitWinnerListenerSubscriptionBloc extends Bloc<
    GameGroupForfitWinnerListnerSubscriptionEvent,
    GameGroupForfitWinnerListnerSubscriptionState> {
  final log = Logger();
  final AuthPageRepository authPageRepository;
  final GamePageRepository gamePageRepository;
  final GameGroupInfo gameGroupInfo;
  late Snapshot snapshot;

  final List<String> forfeitPlayersIdsNotifications = [];

  GameGroupForfeitWinnerListenerSubscriptionBloc(
      {required this.gamePageRepository,
      required this.authPageRepository,
      required this.gameGroupInfo})
      : super(GameGroupForfitWinnerListnerSubscriptionInitial()) {
    ///START ForfeitWinnerListener SUBSCRIPTION
    startForfeitWinnerListener();

    on<GameGroupForfitWinnerListnerSubscriptionEvent>((event, emit) {});
  }

  void startForfeitWinnerListener() async {
    log.wtf("SNAPSHOT => ACTIVE PLAYER startForfeitWinnerListener called");

    ///GET USER ID
    String userId = await authPageRepository.getUserId();

    snapshot = await gamePageRepository.listenForForfeitWinner(
      userId: userId,
      quizGroupId: gameGroupInfo.groupQuizId,
    );

    snapshot.listen((event) {
      try {
        log.d("SNAPSHOT => ACTIVE PLAYER $event");

        List<GameGroupActivePlayer> gameGroupActivePlayers =
            (event['data']['game_groupActivePlayer'] as List)
                .map((e) => GameGroupActivePlayer.fromJson(e))
                .toList();

        ///GET LIST OF ACTIVE PLAYERS
        int activePlayersLength =
            gameGroupActivePlayers.where((element) => element.isActive).length;

        log.d(
            "SNAPSHOT => ACTIVE PLAYER activePlayersLength ${activePlayersLength}");

        ///IF LENGTH IF ACTIVE PLAYERS IS ONE
        ///THEN THERE IS A WINNER
        if (activePlayersLength == 1) {
          GameGroupActivePlayer gameGroupActivePlayer =
              gameGroupActivePlayers.where((element) => element.isActive).first;

          ///CHECK THE WINNER IS SELF
          if (gameGroupActivePlayer.userId == userId) {
            emit(
              GameGroupPlayerWinnerState(
                winningPrize: getWiningAmount(gameGroupActivePlayers.length,gameGroupInfo.vatPer,gameGroupInfo.amountPerPerson,),
                numberOfPlayers: gameGroupActivePlayers.length.toString(),
                placedBet: gameGroupInfo.amountPerPerson.toString(),
                vatPer: gameGroupInfo.vatPer.toString(),
                vatDeducted: getVatDeductedAmount(gameGroupActivePlayers.length,gameGroupInfo.vatPer,gameGroupInfo.amountPerPerson,),
              ),
            );
          }
        }

        ///GET LIST OF FORFEITED USERS TO SHOW NOTIFICATION
        List<GameGroupActivePlayer> forfeitedPlayers = gameGroupActivePlayers
            .where((element) => !element.isActive)
            .toList();
        log.d(
            "SNAPSHOT => ACTIVE PLAYER forfeitedPlayers ${forfeitedPlayers.length}");

        if (forfeitedPlayers.isNotEmpty) {
          List<GameGroupActivePlayer> showForfitNotifyList = [];
          forfeitedPlayers.forEach((forfeitedPlayer) {
            bool isPrevShown = false;

            forfeitPlayersIdsNotifications
                .forEach((forfitPlayersIdsNotification) {
              if (forfeitedPlayer.userId == forfitPlayersIdsNotification) {
                ///NOTIFICATION SHOW PREVIOUSLY
                isPrevShown = true;
              }
            });

            if (!isPrevShown && forfeitedPlayer.userId != userId) {
              showForfitNotifyList.add(forfeitedPlayer);
            }
          });

          emit(
            GameGroupForfitShowNotificationState(
              showForfitNotifyList: showForfitNotifyList,
            ),
          );
        }
      } catch (e) {
        log.d("SNAPSHOT => ACTIVE PLAYER error ${e.toString()}");
      }
    });
  }

  String getWiningAmount(int allPlayersLength, int vatPer, double amountPerPerson) {

    double a = allPlayersLength*amountPerPerson;

    double b = (vatPer*a)/100;

    double c = a-b;

    print("CALCU => $a $b $c");

    return c.toString();
  }

  getVatDeductedAmount(int allPlayersLength, int vatPer, double amountPerPerson) {
    double a = allPlayersLength*amountPerPerson;

    double b = (vatPer*a)/100;

    return b.toString();
  }
}
