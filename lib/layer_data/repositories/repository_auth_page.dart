import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/layer_data/services/service_category_page.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';
import 'package:quiz_bet/layer_data/services/service_home_page.dart';

class AuthPageRepository {
  const AuthPageRepository({
    required this.service,
  });
  final AuthPageService service;

  Future<String> getUserId() async => service.getUserId();
}
