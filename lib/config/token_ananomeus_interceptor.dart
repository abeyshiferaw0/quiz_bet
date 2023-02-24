import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_auth_page.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/layer_data/models/user.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';

class TokenAnonymousInterceptor extends InterceptorBase {
  final log = Logger();


  @override
  Future? onRequest(Request request, HasuraConnect connect) {
    // TODO: implement onRequest
    try {
      request.headers["x-hasura-admin-secret"] =
          "8ShURDi6roXj9tmejrWwX992by5S5Q";
      request.headers["role"] =
          (AppHiveBoxes.instance.authBox.get(Constants.userKey) as User)
              .role
              .first;
      request.headers["Authorization"] =
          "Bearer ${(AppHiveBoxes.instance.authBox.get(Constants.tokensKey) as Tokens).refreshToken}";
      return Future.value(request);
    } catch (e) {
      log.e(e.toString());
      return null;
    }
  }

}
