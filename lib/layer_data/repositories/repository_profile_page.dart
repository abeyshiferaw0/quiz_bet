import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/models/profile_page_data.dart';
import 'package:quiz_bet/layer_data/models/sign_in_data.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/layer_data/models/user.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/layer_data/services/service_category_page.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';
import 'package:quiz_bet/layer_data/services/service_home_page.dart';
import 'package:quiz_bet/layer_data/services/service_profile_page.dart';

class ProfilePageRepository {
  const ProfilePageRepository({
    required this.service,
  });
  final ProfilePageService service;

  Future<ProfilePageData> getProfileData() async => service.getProfileData();

}
