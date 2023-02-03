
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/services/service_category_page.dart';
import 'package:quiz_bet/layer_data/services/service_home_page.dart';

class HomePageRepository {
  const HomePageRepository({
    required this.service,
  });
  final HomePageService service;

  Future<HomePageData> getHomeData() async => service.getHomeData();

}