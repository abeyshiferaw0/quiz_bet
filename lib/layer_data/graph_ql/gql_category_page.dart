class GqlCategoryPage{

    String getAllCategories(){
        return """
            query MyQuery {
              game_categoryList {
                id
                icon {
                  id
                  name
                }
                name_json
                description_json
              }
            }
        """;
    }

}