import 'package:quiz_bet/layer_data/models/game_level.dart';

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
}
