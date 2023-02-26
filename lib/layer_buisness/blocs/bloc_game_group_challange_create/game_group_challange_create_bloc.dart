
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_group_challange_create_event.dart';
part 'game_group_challange_create_state.dart';

class GameGroupChallangeCreateBloc
    extends Bloc<GameGroupChallangeCreateEvent, GameGroupChallangeCreateState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;

  GameGroupChallangeCreateBloc(
      {required this.gamePageRepository, required this.authPageRepository})
      : super(GameGroupChallangeCreateInitial()) {
    on<GameGroupChallangeCreateEvent>((event, emit) async {
      if (event is GameGroupCreateChallangeeEvent) {
        ///EMIT LOADING
        emit(GameGroupChallangeCreateLoadingState());

        try {
          ///GET USER ID
          String userId = await authPageRepository.getUserId();

          String groupQuizId = await gamePageRepository.createGroupGame(
            userId: userId,
            amountPerPerson: event.amountPerPerson,
            categoryId: event.categoryId,
            levelId: event.levelId,
          );

          ///EMIT LOADED
          emit(
            GameGroupChallangeCreateLoadedState(groupQuizId: groupQuizId),
          );
        } catch (e) {
          emit(GameGroupChallangeCreateLoadingErrorState(
            error: e.toString(),
          ));
        }
      } else {
        throw 'EVENT NOT KNOWN';
      }
    });
  }
}
