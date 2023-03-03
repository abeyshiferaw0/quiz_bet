import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/page_data_models/create_challange_page_data.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_create_challange_event.dart';
part 'game_group_create_challange_state.dart';

class GameGroupCreateChallangeBloc extends Bloc<GameGroupCreateChallangeEvent, GameGroupCreateChallangeState> {

  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;


  GameGroupCreateChallangeBloc(
      {required this.gamePageRepository, required this.authPageRepository}) : super(GameGroupCreateChallangeInitial()) {
    on<GameGroupCreateChallangeEvent>((event, emit) async{

      if (event is FetchInitialInfo) {

        emit(GameGroupCreateChallangeLoadingState());

        // //TODO
        // ///DEBUG
        // String userId = await authPageRepository.getUserId();
        // CreateChallangePageData createChallangePageData = await gamePageRepository.getInitialInfoCreateChallange(
        //   userId: userId,
        // );
        // //REMOVE

        try {
          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          CreateChallangePageData createChallangePageData = await gamePageRepository.getInitialInfoCreateChallange(
             userId: userId,
          );

          ///EMIT LOADED
          emit(
            GameGroupCreateChallangeLoadedState(createChallangePageData:createChallangePageData),
          );
        } catch (e) {
          emit( GameGroupCreateChallangeLoadingErrorState(
            error: e.toString(),
          ));
        }


      }else{
        throw 'event not known';
      }

    });
  }
}
