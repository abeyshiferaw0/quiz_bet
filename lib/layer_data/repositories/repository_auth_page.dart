import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/models/sign_in_data.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/layer_data/models/user.dart';
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

  Future<String> signUp(
          {required String name,
          required String phoneNumber,
          required String email,
          required String password}) async =>
      service.signUp(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );

  Future<SignInData> signIn(
          {required String phoneNumber, required String password}) async =>
      service.signIn(
        phoneNumber: phoneNumber,
        password: password,
      );


  Future<void> forgotPassword({required String phoneNumber}) async =>
      service.forgotPassword(phoneNumber);

   resetPassword(
          {required String phoneNumber,
          required newPassword,
          required String otp}) async =>
      service.resetPassword(
        phoneNumber: phoneNumber,
        newPassword: newPassword,
        otp: otp,
      );

  void saveUser(User user) async => service.saveUser(user);

  void saveTokens(Tokens tokens) async => service.saveTokens(tokens);

}
