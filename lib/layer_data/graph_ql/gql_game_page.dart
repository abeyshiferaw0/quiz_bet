import 'package:flutter/foundation.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';

class GqlGamePage {
  String insertGameQuiz({
    required String categoryId,
    required String userId,
    required int amountToBet,
    required String initialLevelId,
  }) {
    return """            
            mutation MyMutation {
              insert_game_quiz_one(object:{category_id:"$categoryId",user_id:"$userId",level_id:"$initialLevelId",amount:"$amountToBet"}){
                id
              }
            }  
        """;
  }

  String updateQuizLevel({
    required String quizId,
    required String levelId,
  }) {
    return """            
          mutation updateGameQuiz{
              update_game_quiz_by_pk(pk_columns:{id:"$quizId"},_set:{level_id:"$levelId"}){
              id
              }
          }
        """;
  }

  String getGameLevelData({
    required String categoryId,
  }) {
    return """
         query getGameLevelData {
          game_categoryList_by_pk(id:"$categoryId"){
            id
            name_json
            description_json
            icon{
              id
              name
            }
            levels(order_by: {level_key: asc}){
              id
              name_json
              level_key
              odds
              questions{
                id
                question_json
                hint
                active
                max_time_in_seconds
                quizQuestionChoice{
                  id
                  choices
                  correct
                }
              }
            }
          }
          system_percentage(where:{code:{_eq:VAT}}){
            name
            percentage
          }
        }        
""";
  }

  String getUserBalace() {
    return """
        mutation getUserBalace{
            getWallet{
              balance
            }
        }            
    """;
  }

  String saveGameHistory(String quizId, GameLevel level, int timeTaken) {
    List<String> objects = [];

    level.questions.forEach((element) {
      objects.add(
          '{quiz_id:"$quizId",question_id:"${element.id}",answer:"${element.choice.usersAnswer!.option}",time_taken:"$timeTaken"}');
    });

    print("objects => ${objects.join(",")}");

    return """
      mutation saveGameHistory {  
        insert_game_gamePlayHistory(objects:[${objects.join(",")}]){
          returning{
            id
          }
        }
      }
    """;
  }

  String saveGroupGameHistory({
    required String userId,
    required String answer,
    required bool isCorrect,
    required String questionId,
    required String groupQuizId,
    required int timeTaken,
  }) {
    String mutation = """
        mutation saveGroupGameHistory{
          insert_game_gamePlayHistoryGroup_one(object:{answer:"$answer",is_correct:$isCorrect,question_id:"$questionId",quiz_id:"$groupQuizId",time_taken:$timeTaken,user_id:"$userId"}){
            id
          }
    """;

    String setActiveMutation = """
       update_game_groupActivePlayer(where:{user_id:{_eq:"$userId"},quiz_group_id:{_eq:"$groupQuizId"}},_set:{isActive:$isCorrect}){
          returning{
            user_id
          }
       }
    """;

    if (!isCorrect) {
      mutation = '$mutation $setActiveMutation';
    }
    mutation = "$mutation}";

    print("mutation=> ${mutation}");

    return mutation;
  }

  String saveGameForfitHistory(String quizId, GameLevel level, int timeTaken,
      Choice choice, GameQuestion gameQuestion) {
    return """
      mutation saveGameHistory {  
        insert_game_gamePlayHistory_one(object:{quiz_id:"$quizId",question_id:"${gameQuestion.id}",answer:"${choice.option}",time_taken:"$timeTaken"}){
           id
        }
      }
    """;
  }

  String initialInfoCreateChallange({required String userId}) {
    return """
          query initialInfoCreateChallange {
            game_categoryList {
              id
              name_json
              description_json
              icon {
                id
                name
              }
              levels(order_by: {level_key: asc}) {
                id
                name_json
                level_key
                odds
                questions {
                  id
                  question_json
                  hint
                  active
                  max_time_in_seconds
                  quizQuestionChoice {
                    id
                    choices
                    correct
                  }
                }
              }
            }
          }
    """;
  }

  String createGroupGame(
      {required String userId,
      required String amountPerPerson,
      required String categoryId,
      required String levelId}) {
    return """
        mutation createGroupGame{
          insert_game_quizGroup_one(object:{amount_per_person:"$amountPerPerson",category_id:"$categoryId",users_id:"$userId",level_id:"$levelId"}){
            id
            amount_per_person
          }
        }
    """;
  }

  addUserToActivePlayer({required String quizGroupId, required String userId}) {
    return """
        mutation a {
          insert_game_groupActivePlayer_one(object: {isActive: true, quiz_group_id: "$quizGroupId", user_id: "$userId"}) {
            id
          }
        }
    """;
  }

  String getGroupInfo({required String userId}) {
    return """
          query mm {
            game_quizGroup_by_pk(id: "01a6d438-bcfe-47d8-9f38-8083b8df62a2") {
              amount_per_person
              categoryList {
                id
                icon {
                  id
                  name
                }
                name_json
                description_json
              }
              level {
                id
                name_json
                level_key
                odds
                questions {
                  id
                  question_json
                  hint
                  active
                  max_time_in_seconds
                  quizQuestionChoice {
                    id
                    choices
                    correct
                  }
                }
              }
            }
          }
    """;
  }

  String findGroupChallange(
      {required String userId, required String groupQuizId}) {
    return """
        query mm {
          game_quizGroup_by_pk(id: "01a6d438-bcfe-47d8-9f38-8083b8df62a2") {
            amount_per_person
            categoryList {
              id
              icon {
                id
                name
              }
              name_json
              description_json
            }
            level {
              id
              name_json
              level_key
              odds
              questions {
                id
                question_json
                hint
                active
                max_time_in_seconds
                quizQuestionChoice {
                  id
                  choices
                  correct
                }
              }
            }
          }
      }

    """;
  }

  String joinGroupGame({required String userId, required String groupQuizId}) {
    return """
         mutation joinGroupGame {
            insert_game_groupActivePlayer_one(object: {isActive: true, user_id: "$userId", quiz_group_id: "$groupQuizId"}) {
              id
            }
         }
    """;
  }

  String getGroupGameInfo(
      {required String userId,
      required String categoryId,
      required groupQuizId}) {
    return """
           query getGameLevelData {
              game_categoryList_by_pk(id:"$categoryId"){
                id
                name_json
                description_json
                icon{
                  id
                  name
                }
                levels(order_by: {level_key: asc}){
                  id
                  name_json
                  level_key
                  odds
                  questions{
                    id
                    question_json
                    hint
                    active
                    max_time_in_seconds
                    quizQuestionChoice{
                      id
                      choices
                      correct
                    }
                  }
                }
              }
              system_percentage(where:{code:{_eq:VAT}}){
                name
                percentage
              }
              
              game_quizGroup_by_pk(id: "$groupQuizId") {
                amount_per_person
              }
          }        
 
    """;
  }

  groupGameJoinedSubscribe(
      {required String userId, required String quizGroupId}) {
    return """
   
      subscription groupGameJoinedSubscribe{
        game_groupActivePlayer(where:{user_id:{_neq:"$userId"},quiz_group_id:{_eq:"$quizGroupId"}}){
          user{
            id
            full_name
            user_name
            phone_number
          }
        }
      }
   
    """;
  }

  String startGroupGame({required String userId, required String quizGroupId}) {
    return """
    mutation m{
      update_game_quizGroup_by_pk(pk_columns:{id:"$quizGroupId"},_set:{status:"STARTED"}){
        id
      }
    }
    """;
  }

  listenForGroupGameStarted(
      {required String userId, required String quizGroupId}) {
    return """
      subscription listenForGroupGameStarted{
        game_quizGroup_by_pk(id:"$quizGroupId"){
          id
          status
        }
      }
    """;
  }

  listenForForfeitWinner({required String userId, required String quizGroupId}){
    return """
        subscription sub{
          game_groupActivePlayer(where:{quiz_group_id:{_eq:"$quizGroupId"}}){
            id
            quiz_group_id
            isActive
            user_id
            user{
              user_name
            }
          }
        }
    """;
  }
}
