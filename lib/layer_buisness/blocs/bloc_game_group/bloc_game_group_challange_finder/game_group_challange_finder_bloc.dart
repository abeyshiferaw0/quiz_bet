import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/page_data_models/find_group_challange_page_data.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_challange_finder_event.dart';
part 'game_group_challange_finder_state.dart';

class GameGroupChallangeFinderBloc
    extends Bloc<GameGroupChallangeFinderEvent, GameGroupChallangeFinderState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;

  GameGroupChallangeFinderBloc(
      {required this.gamePageRepository, required this.authPageRepository})
      : super(GameGroupChallangeFinderInitial()) {
    on<GameGroupChallangeFinderEvent>((event, emit) async {
      if (event is FindeGameGroupChallangeEvent) {
        ///EMIT LOADING
        emit(GameGroupChallangeFinderLoadingState());


       // ///TODO
       //  ///REMOVE AFTER DEBUG
       //  String userId = await authPageRepository.getUserId();
       //
       //  FindGroupChallangePageData findGroupChallangePageData = await gamePageRepository.findGroupChallange(
       //    userId: userId,
       //    groupQuizId: event.groupQuizId,
       //  );
       //  ////

        try {
          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          FindGroupChallangePageData findGroupChallangePageData = await gamePageRepository.findGroupChallange(
            userId: userId,
            groupQuizId: event.groupQuizId,
          );

          ///EMIT LOADED
          emit(
            GameGroupChallangeFinderLoadedState(findGroupChallangePageData: findGroupChallangePageData),
          );
        } catch (e) {
          emit(GameGroupChallangeFinderLoadingErrorState(
            error: e.toString(),
          ));
        }
      }
    });
  }
}
