import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';

part 'game_group_main_page_event.dart';

part 'game_group_main_page_state.dart';

class GameGroupMainPageBloc
    extends Bloc<GameGroupMainPageEvent, GameGroupMainPageState> {
  int currentLevelIndex = 0;
  final GameGroupInfo gameGroupInfo;

  GameGroupMainPageBloc(this.gameGroupInfo)
      : super(GameGroupMainPageInitial()) {
    on<GameGroupMainPageEvent>((event, emit) async {
      if (event is StartGroupGameLevel) {
        ///START PLAYING CURRENT LEVEL
        GameLevel currentLevel =
            gameGroupInfo.levels.elementAt(currentLevelIndex);

        emit(
          GameGroupPlayLevelState(gameLevel: currentLevel),
        );
      }

      if (event is NextGroupGameLevel) {
        ///CHECK IF IS LAST LEVEL

        if (gameGroupInfo.levels.length - 1 == currentLevelIndex) {
          ///LEVELS ENDED
          emit(
            GameGroupPlayLevelDoneState(),
          );
        } else {
          ///INCREMENT CURRENT LEVEL
          currentLevelIndex++;

          ///START PLAYING CURRENT LEVEL
          GameLevel currentLevel =
              gameGroupInfo.levels.elementAt(currentLevelIndex);

          emit(
            GameGroupPlayLevelState(gameLevel: currentLevel),
          );
        }
      }
    });
  }
}
