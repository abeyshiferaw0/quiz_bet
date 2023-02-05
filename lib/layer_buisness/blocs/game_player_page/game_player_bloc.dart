import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';

part 'game_player_event.dart';
part 'game_player_state.dart';

class GamePlayerBloc extends Bloc<GamePlayerEvent, GamePlayerState> {
  final log = Logger();
  final GamePageRepository gamePageRepository;
  final AuthPageRepository authPageRepository;

  ///GAME TRACKING VALUES
  late GameInfo gameInfo;
  int gameLevelIndex = 0;

  GamePlayerBloc(
      {required this.gamePageRepository, required this.authPageRepository})
      : super(GamePlayerInitial()) {
    on<GamePlayerEvent>((event, emit) {
      if (event is GameStartedEvent) {
        gameInfo = event.gameInfo;
        gameLevelIndex = 0;

        ///PLAY INITIAL GAME LEVEL
        emit(GamePlayerPlayLevelState(
          gameInfo: gameInfo,
          gameLevel: event.gameInfo.levels.elementAt(gameLevelIndex),
          curentLevelIndex: gameLevelIndex,
        ));
      }

      if (event is GameNextLevelEventEvent) {
        ///INCREASE LEVEL INDEX
        gameLevelIndex++;

        print("islastLevel =>>> TRUE ${gameLevelIndex}");

        if (islastLevel(gameInfo, gameLevelIndex)) {
          ///PLAY INITIAL GAME LEVEL
          emit(const GamePlayerLevelsDoneState());
        } else {
          ///PLAY INITIAL GAME LEVEL
          emit(GamePlayerPlayLevelState(
            gameInfo: gameInfo,
            gameLevel: event.gameInfo.levels.elementAt(gameLevelIndex),
            curentLevelIndex: gameLevelIndex,
          ));
        }
      }
    });
  }

  islastLevel(GameInfo gameInfo, int gameLevelIndex) {
    if ((gameInfo.levels.length ) == gameLevelIndex) {
      print("islastLevel =>>> TRUE ${gameInfo.levels.length}");
      return true;

    } else {
      print("islastLevel =>>> FALSE ${gameInfo.levels.length}");
      return false;
    }
  }
}
