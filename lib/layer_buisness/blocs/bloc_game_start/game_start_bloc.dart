import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_start_event.dart';
part 'game_start_state.dart';

class GameStartBloc extends Bloc<GameStartEvent, GameStartState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;

  GameStartBloc(
      {required this.gamePageRepository, required this.authPageRepository})
      : super(GameStartInitial()) {
    on<GameStartEvent>((event, emit) async {
      if (event is StartGameEvent) {
        ///EMIT LOADING
        emit(GameStartLoading());

        // //TODO
        // ///DEBUG REMOVE
        // String userId = await authPageRepository.getUserId();
        // GameInfo gameInfo = await gamePageRepository.startGameLevel(
        //   categoryId: event.category.id,
        //   userId: userId,
        //   amountToBet: event.amountToBet,
        //   initialLevelId: event.initialLevelId,
        // );
        // ////

        try {

          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          GameInfo gameInfo = await gamePageRepository.startGameLevel(
            categoryId: event.category.id,
            userId: userId,
            amountToBet: event.amountToBet,
            initialLevelId: event.initialLevelId,
          );


          ///EMIT LOADED
          emit(
            GameStartLoaded(gameInfo:gameInfo),
          );
        } catch (e) {
         emit( GameStartLoadingError(
           error: e.toString(),
         ));
        }
      } else {
        throw 'event not known';
      }
    });
  }
}
