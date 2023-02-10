import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_initial_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';

class GamePageRepository {
  const GamePageRepository({
    required this.service,
  });
  final GamePageService service;

  Future<GameInitialInfo> getGameInfo(
          {required String categoryId, required String userId}) async =>
      service.getGameInfo(
        categoryId,
        userId,
      );

  Future<GameInfo> startGameLevel(
      {required String categoryId, required String userId,required int amountToBet,required String initialLevelId}) async =>
      service.startGameLevel(
        categoryId,
        userId,
          amountToBet,
          initialLevelId,
      );

  Future<void> saveGameHistory(String quizId, GameLevel gameLevel, int timeTaken) async =>
      service.saveGameHistory(
        quizId,
        gameLevel,
          timeTaken,
      );

  Future<void> updateQuizLevel(String quizId, String levelId) async =>       service.updateQuizLevel(
    quizId,
    levelId,
  );
}
