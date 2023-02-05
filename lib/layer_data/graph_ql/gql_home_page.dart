class GqlHomePage{

    String getHomeData(){
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
              system_ads(where: {active: {_eq: true}}) {
                id
                title
                description
                image {
                  id
                  small_image
                  medium_image
                  large_image
                }
              }
              game_trending {
                id
                icon_id
                image{
                  id
                  small_image
                  medium_image
                  large_image
                 }
                categoryList {
                  id
                  icon {
                    id
                    name
                  }
                  levels_aggregate {
                    aggregate {
                      count
                    }
                  }
                  levels {
                    questions_aggregate {
                      aggregate {
                        count
                      }
                    }
                  }
                  levels {
                    odds
                  }
                  name_json
                  description_json
                }
              }
            }

        """;
    }

}