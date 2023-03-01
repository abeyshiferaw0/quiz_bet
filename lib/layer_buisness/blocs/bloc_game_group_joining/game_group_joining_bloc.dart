import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_joining_event.dart';
part 'game_group_joining_state.dart';

class GameGroupJoiningBloc extends Bloc<GameGroupJoiningEvent, GameGroupJoiningState> {

  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;


  GameGroupJoiningBloc({required this.gamePageRepository, required this.authPageRepository}) : super(GameGroupJoiningInitial()) {

    on<GameGroupJoiningEvent>((event, emit) async{

      if (event is JoinGameGroupEvent) {

        emit(GameGroupJoiningLoadingState());

        try {
          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          GameGroupInfo gameGroupInfo = await gamePageRepository.joinGroupGame(
            userId: userId,
            groupQuizId:event.groupQuizId,
            categoryId:event.categoryId,
          );

          ///EMIT LOADED
          emit(
            GameGroupJoiningLoadedState(gameGroupInfo:gameGroupInfo),
          );
        } catch (e) {
          emit( GameGroupJoiningLoadingErrorState(
            error: e.toString(),
          ));
        }

      }

    });

  }
}
