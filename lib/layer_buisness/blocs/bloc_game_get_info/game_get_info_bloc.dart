import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_initial_info.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_get_info_event.dart';
part 'game_get_info_state.dart';

class GameGetInfoBloc extends Bloc<GameGetInfoEvent, GameGetInfoState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;

  GameGetInfoBloc(
      {required this.gamePageRepository, required this.authPageRepository})
      : super(GameGetInfoInitial()) {
    on<GameGetInfoEvent>((event, emit) async{

      if (event is GetInfoEvent) {
        ///EMIT LOADING
        emit(GameGetInfoLoadingState());

        try {
          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          GameInitialInfo gameInitialInfo = await gamePageRepository.getGameInfo(
            categoryId: event.categoryId,
            userId: userId,
          );

          ///EMIT LOADED
          emit(
            GameGetInfoLoadedState(gameInitialInfo:gameInitialInfo),
          );
        } catch (e) {
          emit( GameGetInfoLoadingErrorState(
            error: e.toString(),
          ));
        }
      } else {
        throw 'event not known';
      }
    });
  }
}
