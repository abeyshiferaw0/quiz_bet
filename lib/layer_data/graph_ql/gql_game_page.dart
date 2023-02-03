class GqlGamePage {
  String insertGameQuiz({
    required String categoryId,
    required String userId,
  }) {
    return """
            mutation insertGameQuiz {
              insert_game_quiz_one(object: {category_id:"$categoryId",user_id:"$userId"}) {
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
          game_categoryList_by_pk(id:"81e9d82a-4664-4815-aa48-757da2c090ad"){
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



}
