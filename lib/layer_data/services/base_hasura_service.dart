import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/config/token_ananomeus_interceptor.dart';
import 'package:quiz_bet/config/token_interceptor.dart';
import 'package:quiz_bet/config/token_refresh_interceptor.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_auth_page.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/main.dart';

class BaseHasuraService {
  final log = Logger();

  final HasuraConnect hasuraConnect = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenInterceptor()],
  );

  final HasuraConnect hasuraConnectSignInUp = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenAnonymousInterceptor()],
  );

  final HasuraConnect hasuraConnectTokenRefresh = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenRefreshInterceptor()],
  );

  GqlAuthPage gqlAuthPage = GqlAuthPage();

  Future refreshToken() async {
    log.wtf(
        "REFRESHCALLED => ${(AppHiveBoxes.instance.authBox.get(Constants.tokensKey) as Tokens).refreshToken}");

    var refreshTokenResult = await hasuraConnectTokenRefresh.mutation(
      gqlAuthPage.refreshToken(),
    );

    log.wtf("REFRESHCALLED RESULT  => ${refreshTokenResult}");

    Tokens tokens =
        Tokens.fromJson(refreshTokenResult['data']['refreshToken']['tokens']);
    AppHiveBoxes.instance.authBox.put(Constants.tokensKey, tokens);

    return refreshTokenResult;
  }

  static void logOut() {
    AppHiveBoxes.instance.authBox.clear();
    navigatorKey.currentState?.popUntil(
      ModalRoute.withName(AppRouterPaths.mainScreen),
    );
    navigatorKey.currentState!.popAndPushNamed(AppRouterPaths.splashRoute);
  }

  query({required String document}) async {
    try {
      ///SEND QUERY
      var result = await hasuraConnect.query(document);
      return result;
    } catch (e) {
      log.e("HASURA ERROR => ${e.toString()}");

      ///IF ERROR CHECK IF TOKEN EXPIRED
      if (e.toString().toLowerCase().contains('token_invalid')) {
        try {
          ///IF REFRESHING SUCCESSFULLY TRY REQUEST AGAIN
          var refreshTokenResult = await refreshToken();
          query(document: document);
        } catch (e) {
          ///IF TRYING TO REFRESH FAILED
          ///LOGOUT
          logOut();
          return;
        }
      }
    }
  }

  mutation({required String document}) async {
    try {
      ///SEND QUERY
      var result = await hasuraConnect.mutation(document);
      log.e("HASURA mutation => ${result.toString()}");
      return result;
    } catch (e) {
      log.e("HASURA ERROR => ${e.toString()}");

      ///IF ERROR CHECK IF TOKEN EXPIRED
      if (e.toString().toLowerCase().contains('unauthorized')) {
        try {
          ///IF REFRESHING SUCCESSFULLY TRY REQUEST AGAIN
          var refreshTokenResult = await refreshToken();

          mutation(document: document);
        } catch (e) {
          log.e("HASURA ERROR REFRESHING => ${e.toString()}");

          ///IF TRYING TO REFRESH FAILED
          ///LOGOUT
          logOut();
          return;
        }
      }
    }
  }

  signInUp({required String document}) async {
    try {
      ///SEND QUERY
      var result = await hasuraConnectSignInUp.mutation(document);
      return result;
    } catch (e) {
      return;
    }
  }
}
