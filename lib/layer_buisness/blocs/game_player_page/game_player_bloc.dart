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
          gameLevel: event.gameInfo.levels.elementAt(gameLevelIndex),
        ));
      }

      if (event is GameNextLevelEventEvent) {
        ///INCREASE LEVEL INDEX
        gameLevelIndex++;

        ///PLAY NEXT LEVEL
        emit(
          GamePlayerPlayLevelState(
            gameLevel: gameInfo.levels.elementAt(gameLevelIndex),
          ),
        );
      }
    });
  }
}
