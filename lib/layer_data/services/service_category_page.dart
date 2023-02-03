import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_category_page.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/config/token_interceptor.dart';


class CategoryPageService {
  final log = Logger();
  CategoryPageService();

  //final TokenInterceptor tokenInterceptor = TokenInterceptor();
  final HasuraConnect hasuraConnect = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenInterceptor()],
  );
  final GqlCategoryPage gqlCategories = GqlCategoryPage();

  Future<List<Category>> getAllCategories() async {
    try {
      var response =
          await hasuraConnect.query(gqlCategories.getAllCategories());

      log.i("getAllCategories response => ${response['data']['game_categoryList']}");

      List<Category> categoryList = (response['data']['game_categoryList'] as List)
          .map((category) => Category.fromJson(category))
          .toList();



      return categoryList;
    } catch (e) {
      log.e("getAllCategories => ${e.toString()}");
      rethrow;
    }
  }
}
