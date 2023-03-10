import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_category_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_home_page.dart';
import 'package:quiz_bet/layer_data/models/ad.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/category_trending.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/config/token_interceptor.dart';
import 'package:quiz_bet/layer_data/services/base_hasura_service.dart';

class HomePageService {
  final log = Logger();
  HomePageService();

  BaseHasuraService baseHasuraService = BaseHasuraService();


  final GqlHomePage gqlHomePage = GqlHomePage();

  Future<HomePageData> getHomeData() async {
    try {
      var response = await baseHasuraService.query(document: gqlHomePage.getHomeData(),);

      List<Category> categoryList =
          (response['data']['game_categoryList'] as List)
              .map((category) => Category.fromJson(category))
              .toList();

      List<Ad> ads = (response['data']['system_ads'] as List)
          .map((ad) => Ad.fromJson(ad))
          .toList();

      List<CategoryTrending> trendingCategories =
          (response['data']['game_trending'] as List)
              .map((categoryTrending) => CategoryTrending.fromJson(categoryTrending))
              .toList();

      return HomePageData(
        categoryList: categoryList,
        ads: ads,
        trendingCategories: trendingCategories,
      );
    } catch (e) {
      log.e("getAllCategories => ${e.toString()}");
      rethrow;
    }
  }
}
