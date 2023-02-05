import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_category_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_game_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_home_page.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/config/token_interceptor.dart';

class GamePageService {
  final log = Logger();

  final HasuraConnect hasuraConnect = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenInterceptor()],
  );
  final GqlGamePage gqlGamePage = GqlGamePage();

  Future<GameInfo> startGameLevel(String categoryId, String userId) async {

     late String quizId ;
     late Category category ;
     late List<GameLevel> levels;

    try {

      ///INSERT GAME QUIZ
      var responseOne = await hasuraConnect.mutation(
        gqlGamePage.insertGameQuiz(
          categoryId: categoryId,
          userId: userId,
        ),
      );

      ///GET GAME LEVELS WITH QUESTIONS
      var responseTwo = await hasuraConnect.query(
        gqlGamePage.getGameLevelData(
          categoryId: categoryId,
        ),
      );


      ///PARSE AND ASSIGN VALUES
      quizId = responseOne['data']['insert_game_quiz_one']['id'];
      category = Category.fromJson(responseTwo['data']['game_categoryList_by_pk']);
      levels = (responseTwo['data']['game_categoryList_by_pk']['levels'] as List)
              .map((level) => GameLevel.fromJson(level))
              .toList();

      log.i("startGameLevel responseOne => ${responseOne}");
      log.i("startGameLevel responseTwo => ${responseTwo}");



      return GameInfo(
        quizId: quizId,
        category: category,
        levels: levels,
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<void> saveGameHistory(String quizId,GameLevel gameLevel, int timeTaken) async {
    try {

      ///INSERT GAME QUIZ
      var response = await hasuraConnect.mutation(
        gqlGamePage.saveGameHistory(
          quizId,gameLevel,timeTaken,
        ),
      );

     return;
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

}
