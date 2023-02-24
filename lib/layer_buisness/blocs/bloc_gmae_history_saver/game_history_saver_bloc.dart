import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_history_saver_event.dart';
part 'game_history_saver_state.dart';

class GameHistorySaverBloc extends Bloc<GameHistorySaverEvent, GameHistorySaverState> {

  final GamePageRepository gamePageRepository;

  GameHistorySaverBloc({required this.gamePageRepository}) : super(GameHistorySaverInitial()) {
    on<GameHistorySaverEvent>((event, emit) async{

      if(event is GameHistorySaverSaveEvent){

        ///EMIT LOADING
        emit(GameHistorySaverLoadingState());

        try {

          await gamePageRepository.saveGameHistory(event.gameInfo.quizId,event.gameLevel,event.timeTaken);

          ///EMIT LOADED
          emit(
            GameHistorySaverLoadedState(),
          );

        } catch (e) {
          ///EMIT LOADING ERROR
          emit(
             GameHistorySaverLoadingErrorState(error: e.toString()),
          );
        }

      }
      else if(event is GameHistorySaverSaveForfitEvent){

        ///EMIT LOADING
        emit(GameHistorySaverLoadingState());

        try {

          await gamePageRepository.saveGameForfitHistory(event.gameInfo.quizId,event.gameLevel,event.timeTaken,event.choice,event.gameQuestion);

          ///EMIT LOADED
          emit(
            GameHistorySaverLoadedState(),
          );

        } catch (e) {
          ///EMIT LOADING ERROR
          emit(
            GameHistorySaverLoadingErrorState(error: e.toString()),
          );
        }

      }else {
        ///EMIT LOADING ERROR
        emit(
          const GameHistorySaverLoadingErrorState(error: 'Event not known'),
        );
      }
    });
  }
}
