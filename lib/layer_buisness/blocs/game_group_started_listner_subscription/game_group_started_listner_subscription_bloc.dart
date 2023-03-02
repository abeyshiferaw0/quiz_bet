import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_started_listner_subscription_event.dart';
part 'game_group_started_listner_subscription_state.dart';

class GameGroupStartedListnerSubscriptionBloc extends Bloc<
    GameGroupStartedListnerSubscriptionEvent,
    GameGroupStartedListnerSubscriptionState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;
  final String quizId;

  late Snapshot snapshot;

  GameGroupStartedListnerSubscriptionBloc(
      {required this.gamePageRepository,
      required this.authPageRepository,
      required this.quizId})
      : super(GameGroupStartedListnerSubscriptionInitial()) {

    ///START LISTENING TO JOINED PLAYERS
    startStartedListner();

    on<GameGroupStartedListnerSubscriptionEvent>((event, emit) async {

      on<GameGroupStartedListnerSubscriptionEvent>((event, emit) async {});
    });
  }

  void startStartedListner() async {
    ///GET USER ID
    String userId = await authPageRepository.getUserId();

    snapshot = await gamePageRepository.listenForGroupGameStarted(
      userId: userId,
      quizGroupId: quizId,
    );

    snapshot.listen((event) {


      try {
        String status =
            (snapshot.value['data']['game_quizGroup_by_pk'] as Map)['status'];
        log.wtf("SNAPSHOT => ${status}");
        if (status == 'STARTED') {
          emit(GroupGameStartedState());
        }
      } catch (e) {
        log.wtf("SNAPSHOT => ${e.toString()}");
      }
    });
  }
}
