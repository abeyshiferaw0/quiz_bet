import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_starting_event.dart';
part 'game_group_starting_state.dart';

class GameGroupStartingBloc extends Bloc<GameGroupStartingEvent, GameGroupStartingState> {

  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;


  GameGroupStartingBloc({required this.gamePageRepository, required this.authPageRepository}) : super(GameGroupStartingInitial()) {
    on<GameGroupStartingEvent>((event, emit) async{

      if(event is StartGroupGameEvent){

        emit(GameGroupStartingLoadingState());

        try {
          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          await gamePageRepository.startGroupGame(
            userId: userId,
            quizGroupId:event.gameGroupInfo.groupQuizId,
          );

          ///EMIT LOADED
          emit(
            GameGroupStartingLoadedState(),
          );
        } catch (e) {
          emit( GameGroupStartingLoadingErrorState(
            error: e.toString(),
          ));
        }


      }

    });
  }
}
