import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_category_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_home_page.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/config/token_interceptor.dart';


class HomePageService {
  final log = Logger();
  HomePageService();

  //final TokenInterceptor tokenInterceptor = TokenInterceptor();
  final HasuraConnect hasuraConnect = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenInterceptor()],
  );
  final GqlHomePage gqlHomePage = GqlHomePage();

  Future<HomePageData> getHomeData() async {
    try {
      var response =
          await hasuraConnect.query(gqlHomePage.getHomeData());

      log.i("getAllCategories response => ${response['data']['game_categoryList']}");

      List<Category> categoryList = (response['data']['game_categoryList'] as List)
          .map((category) => Category.fromJson(category))
          .toList();



      return HomePageData(categoryList: categoryList,);
    } catch (e) {
      log.e("getAllCategories => ${e.toString()}");
      rethrow;
    }
  }
}
