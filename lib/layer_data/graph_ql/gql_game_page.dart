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
}
