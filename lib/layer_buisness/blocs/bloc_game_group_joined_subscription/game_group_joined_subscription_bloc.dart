import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_group_joined_subscription.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_joined_subscription_event.dart';
part 'game_group_joined_subscription_state.dart';

class GameGroupJoinedSubscriptionBloc extends Bloc<
    GameGroupJoinedSubscriptionEvent, GameGroupJoinedSubscriptionState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;
  final String quizId;

  final List<GameGroupJoinedSubscription> gameGroupJoinedSubscription = [];
  late Snapshot snapshot;

  GameGroupJoinedSubscriptionBloc({
    required this.gamePageRepository,
    required this.authPageRepository,
    required this.quizId,
  }) : super(GameGroupJoinedSubscriptionInitial()) {


    ///START LISTENING TO JOINED PLAYERS
    startJoinedListner();

    on<GameGroupJoinedSubscriptionEvent>((event, emit) async {});
  }

  void startJoinedListner() async {
    ///GET USER ID
    String userId = await authPageRepository.getUserId();

    snapshot = await gamePageRepository.listenForGroupGameJoin(
      userId: userId,
      quizGroupId: quizId,
    );

    snapshot.listen((event) {
      log.wtf("SNAPSHOT => ${event}");

      try {
        List<GameGroupJoinedSubscription> list =
            (snapshot.value['data']['game_groupActivePlayer'] as List)
                .map((e) => GameGroupJoinedSubscription.fromJson(e['user']))
                .toList();

        list.forEach((element) {
          gameGroupJoinedSubscription.add(element);
        });

        emit(
          GameGroupJoinedSubState(
            gameGroupJoinedSubscriptions: gameGroupJoinedSubscription,
          ),
        );
      } catch (e) {}
    });
  }
}
