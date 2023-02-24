import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/config/token_interceptor.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_auth_page.dart';
import 'package:quiz_bet/layer_data/models/sign_in_data.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/layer_data/models/user.dart';
import 'package:quiz_bet/layer_data/services/base_hasura_service.dart';
import 'package:quiz_bet/main.dart';

class AuthPageService {
  final log = Logger();

  BaseHasuraService baseHasuraService = BaseHasuraService();

  final GqlAuthPage gqlAuthPage = GqlAuthPage();

  Future<String> getUserId() async {
    User user = AppHiveBoxes.instance.authBox.get(Constants.userKey);

    return user.id;
  }

  Future<String> signUp(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.signInUp(
       document: gqlAuthPage.signUp(
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        ),
      );

      return response['data']['signUp']['message'];
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");

      if (e.toString().contains('CREDENTIALS_IS_ALREADY_IN_USE') ||
          e.toString().contains('USER_ACCOUNT_NOT_CREATED')) {
        return 'CREDENTIALS_IS_ALREADY_IN_USE';
      }

      rethrow;
    }
  }

  Future<SignInData> signIn(
      {required String phoneNumber, required String password}) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.signInUp(
        document:    gqlAuthPage.signIn(
          phoneNumber: phoneNumber,
          password: password,
        ),
      );

      Tokens tokens = Tokens.fromJson(response['data']['signIn']['tokens']);

      User user = User.fromJson(response['data']['signIn']['data']);

      return SignInData(
        tokens: tokens,
        user: user,
      );
    } catch (e) {
      log.e("signIn => ${e.toString()}");
      rethrow;
    }
  }

  Future<void> forgotPassword(String phoneNumber) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.mutation(
        document:  gqlAuthPage.forgotPassword(
          phoneNumber: phoneNumber,
        ),
      );

      return;
    } catch (e) {
      log.e("forgotPassword => ${e.toString()}");
      rethrow;
    }
  }

  resetPassword(
      {required String phoneNumber,
      required newPassword,
      required String otp}) async {
    try {
      ///INSERT GAME QUIZ
      var response = await baseHasuraService.mutation(
        document:  gqlAuthPage.resetPassword(
          phoneNumber: phoneNumber,
          newPassword: newPassword,
          otp: otp,
        ),
      );

      return response;
    } catch (e) {
      log.e("forgotPassword => ${e.toString()}");
      rethrow;
    }
  }

  saveUser(User user) {
    AppHiveBoxes.instance.authBox.put(Constants.userKey, user);
  }

  saveTokens(Tokens tokens) {
    AppHiveBoxes.instance.authBox.put(Constants.tokensKey, tokens);
  }

  bool isUserLoggedIn() {
    try {
      Tokens tokens =
          AppHiveBoxes.instance.authBox.get(Constants.tokensKey) as Tokens;
      User user = AppHiveBoxes.instance.authBox.get(Constants.userKey) as User;

      if (tokens.accessToken.isEmpty || tokens.refreshToken.isEmpty) {
        return false;
      }

      if (user.id.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static void logOut() {
    AppHiveBoxes.instance.authBox.clear();
    navigatorKey.currentState?.popUntil(
      ModalRoute.withName(AppRouterPaths.mainScreen),
    );
    navigatorKey.currentState!.popAndPushNamed(AppRouterPaths.splashRoute);
  }
}
