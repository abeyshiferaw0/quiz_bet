import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_category_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_game_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_home_page.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_initial_info.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/config/token_interceptor.dart';
import 'package:quiz_bet/layer_data/models/page_data_models/create_challange_page_data.dart';
import 'package:quiz_bet/layer_data/models/page_data_models/find_group_challange_page_data.dart';

import 'base_hasura_service.dart';

class GamePageService {
  final log = Logger();

  BaseHasuraService baseHasuraService = BaseHasuraService();

  final GqlGamePage gqlGamePage = GqlGamePage();

  Future<GameInfo> startGameLevel(String categoryId, String userId,
      int amountToBet, String initialLevelId) async {
    late String quizId;

    late Category category;
    late List<GameLevel> levels;

    try {
      ///GET GAME LEVELS WITH QUESTIONS
      var responseTwo = await baseHasuraService.query(
        document: gqlGamePage.getGameLevelData(
          categoryId: categoryId,
        ),
      );

      ///INSERT GAME QUIZ
      var responseOne = await baseHasuraService.mutation(
        document: gqlGamePage.insertGameQuiz(
          categoryId: categoryId,
          userId: userId,
          amountToBet: amountToBet,
          initialLevelId: initialLevelId,
        ),
      );

      ///PARSE AND ASSIGN VALUES
      quizId = responseOne['data']['insert_game_quiz_one']['id'];
      category =
          Category.fromJson(responseTwo['data']['game_categoryList_by_pk']);
      levels =
          (responseTwo['data']['game_categoryList_by_pk']['levels'] as List)
              .map((level) => GameLevel.fromJson(level))
              .toList();

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

  Future<GameInitialInfo> getGameInfo(String categoryId, String userId) async {
    late Category category;
    late List<GameLevel> levels;
    late double vatPercentage;
    late double balance;

    try {
      ///GET GAME LEVELS WITH QUESTIONS
      var responseOne = await baseHasuraService.query(
        document: gqlGamePage.getGameLevelData(
          categoryId: categoryId,
        ),
      );

      ///GET GAME LEVELS WITH QUESTIONS
      var responseTwo = await baseHasuraService.mutation(
        document: gqlGamePage.getUserBalace(),
      );

      ///PARSE AND ASSIGN VALUES
      category =
          Category.fromJson(responseOne['data']['game_categoryList_by_pk']);
      levels =
          (responseOne['data']['game_categoryList_by_pk']['levels'] as List)
              .map((level) => GameLevel.fromJson(level))
              .toList();
      vatPercentage = ((responseOne['data']['system_percentage'] as List)
              .first['percentage'] as int)
          .toDouble();

      balance = 100.0;
      // balance = responseTwo['data']['getWallet']['balance'] is int
      //     ? (responseTwo['data']['getWallet']['balance'] as int).toDouble()
      //     : responseTwo['data']['getWallet']['balance'];

      log.i("startGameLevel responseTwo => ${responseOne}");

      return GameInitialInfo(
        category: category,
        levels: levels,
        vatPercentage: vatPercentage,
        balance: balance,
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<void> saveGameHistory(
      String quizId, GameLevel gameLevel, int timeTaken) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.mutation(
        document: gqlGamePage.saveGameHistory(
          quizId,
          gameLevel,
          timeTaken,
        ),
      );

      return;
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  saveGameForfitHistory(String quizId, GameLevel gameLevel, int timeTaken,
      Choice choice, GameQuestion gameQuestion) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.mutation(
        document: gqlGamePage.saveGameForfitHistory(
          quizId,
          gameLevel,
          timeTaken,
          choice,
          gameQuestion,
        ),
      );

      return;
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  updateQuizLevel(String quizId, String levelId) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.mutation(
        document: gqlGamePage.updateQuizLevel(
          quizId: quizId,
          levelId: levelId,
        ),
      );

      log.i("response updateQuizLevel ${response}");

      return;
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  getInitialInfoCreateChallange(String userId) async {
    try {
      ///GET CATEGORY AND LEVEL LIST
      var responseOne = await baseHasuraService.query(
        document: gqlGamePage.initialInfoCreateChallange(
          userId: userId,
        ),
      );

      ///INSERT GAME QUIZ
      var responseTwo = await baseHasuraService.mutation(
        document: gqlGamePage.getUserBalace(),
      );

      log.i("getInitialInfoCreateChallange responseOne ${responseOne}");

      log.i("getInitialInfoCreateChallange responseTwo ${responseTwo}");

      return CreateChallangePageData(
        categories: (responseOne['data']['game_categoryList'] as List)
            .map((category) => Category.fromJson(category))
            .toList(),
        walletBalance: 100.0,
        // walletBalance: responseTwo['data']['getWallet']['balance'] is int
        //     ? (responseTwo['data']['getWallet']['balance'] as int).toDouble()
        //     : responseTwo['data']['getWallet']['balance'],
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<GameGroupInfo> createGroupGame(
      {required String userId,
      required String amountPerPerson,
      required String categoryId,
      required String levelId}) async {
    try {
      ///CREATE QUIZ GROUP
      var responseOne = await baseHasuraService.mutation(
        document: gqlGamePage.createGroupGame(
          userId: userId,
          amountPerPerson: amountPerPerson,
          categoryId: categoryId,
          levelId: levelId,
        ),
      );

      String quizGroupId =
          responseOne['data']['insert_game_quizGroup_one']['id'];
      String resAmountPerPerson =
          responseOne['data']['insert_game_quizGroup_one']['amount_per_person'];

      ///ADD USER IN ACTIVE PLAYERS LIST
      var responseTwo = await baseHasuraService.mutation(
        document: gqlGamePage.addUserToActivePlayer(
          userId: userId,
          quizGroupId: quizGroupId,
        ),
      );

      ////
      var responseThree = await baseHasuraService.query(
        document: gqlGamePage.getGroupGameInfo(
          userId: userId,
          categoryId: categoryId,
          groupQuizId: quizGroupId,
        ),
      );

      int varPer = (responseThree['data']['system_percentage'] as List)
          .first['percentage'];

      ///PARSE AND ASSIGN VALUES
      return GameGroupInfo(
        groupQuizId: quizGroupId,
        amountPerPerson: double.parse(resAmountPerPerson.replaceAll("\$", '')),
        vatPer: varPer,
        category:
            Category.fromJson(responseThree['data']['game_categoryList_by_pk']),
        levels:
            (responseThree['data']['game_categoryList_by_pk']['levels'] as List)
                .map((level) => GameLevel.fromJson(level))
                .toList(),
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<FindGroupChallangePageData> findGroupChallange(
      {required String userId, required groupQuizId}) async {
    try {
      ////
      var responseOne = await baseHasuraService.query(
        document: gqlGamePage.findGroupChallange(
          userId: userId,
          groupQuizId: groupQuizId,
        ),
      );

      ///
      var responseTwo = await baseHasuraService.mutation(
        document: gqlGamePage.getUserBalace(),
      );

      log.i("getInitialInfoCreateChallange responseOne ${responseOne}");

      log.i("getInitialInfoCreateChallange responseTwo ${responseTwo}");

      return FindGroupChallangePageData(
        category: Category.fromJson(
            responseOne['data']['game_quizGroup_by_pk']['categoryList']),
        gameLevel: GameLevel.fromJson(
            responseOne['data']['game_quizGroup_by_pk']['level']),
        amountPerPerson: double.parse(responseOne['data']
                ['game_quizGroup_by_pk']['amount_per_person']
            .toString()
            .replaceAll('\$', "")),
        walletBalance: 100.0,
        // walletBalance: responseTwo['data']['getWallet']['balance'] is int
        //     ? (responseTwo['data']['getWallet']['balance'] as int).toDouble()
        //     : responseTwo['data']['getWallet']['balance'],
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<GameGroupInfo> joinGroupGame(
      {required String userId,
      required groupQuizId,
      required String categoryId}) async {
    try {
      ////
      var responseOne = await baseHasuraService.mutation(
        document: gqlGamePage.joinGroupGame(
          userId: userId,
          groupQuizId: groupQuizId,
        ),
      );

      ////
      var responseTwo = await baseHasuraService.query(
        document: gqlGamePage.getGroupGameInfo(
          userId: userId,
          categoryId: categoryId,
          groupQuizId: groupQuizId,
        ),
      );

      log.i("getInitialInfoCreateChallange responseOne ${responseOne}");
      log.i("getInitialInfoCreateChallange responseOne ${responseTwo}");

      String resAmountPerPerson =
          responseTwo['data']['game_quizGroup_by_pk']['amount_per_person'];
      int vatPer = (responseTwo['data']['system_percentage'] as List)
          .first['percentage'];

      ///PARSE AND ASSIGN VALUES
      return GameGroupInfo(
        groupQuizId: groupQuizId,
        amountPerPerson: double.parse(resAmountPerPerson.replaceAll("\$", '')),
        vatPer: vatPer,
        category:
            Category.fromJson(responseTwo['data']['game_categoryList_by_pk']),
        levels:
            (responseTwo['data']['game_categoryList_by_pk']['levels'] as List)
                .map((level) => GameLevel.fromJson(level))
                .toList(),
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<Snapshot> listenForGroupGameJoin(
      {required String userId, required String quizGroupId}) async {
    Snapshot snapshot = await baseHasuraService.subscribe(
      document: gqlGamePage.groupGameJoinedSubscribe(
        userId: userId,
        quizGroupId: quizGroupId,
      ),
    );

    return snapshot;
  }

  startGroupGame({required String userId, required String quizGroupId}) async {
    print("MUTATTION=> ${gqlGamePage.startGroupGame(
      userId: userId,
      quizGroupId: quizGroupId,
    )}");

    try {
      ////
      var responseOne = await baseHasuraService.mutation(
        document: gqlGamePage.startGroupGame(
          userId: userId,
          quizGroupId: quizGroupId,
        ),
      );

      return;
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }

  Future<Snapshot> listenForGroupGameStarted(
      {required String userId, required String quizGroupId}) async {
    Snapshot snapshot = await baseHasuraService.subscribe(
      document: gqlGamePage.listenForGroupGameStarted(
        userId: userId,
        quizGroupId: quizGroupId,
      ),
    );

    return snapshot;
  }
}
