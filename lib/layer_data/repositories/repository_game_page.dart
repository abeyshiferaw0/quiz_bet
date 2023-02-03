import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';

class GamePageRepository {
  const GamePageRepository({
    required this.service,
  });
  final GamePageService service;

  Future<GameInfo> startGameLevel(
      {required String categoryId, required String userId}) async =>
      service.startGameLevel(
        categoryId,
        userId,
      );
}
