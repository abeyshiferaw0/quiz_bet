import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/auth_page.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_category_page.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';

class AuthPageService {
  final log = Logger();
  //final TokenInterceptor tokenInterceptor = TokenInterceptor();
  final HasuraConnect hasuraConnect = HasuraConnect(
    Constants.hasuraUrl,
  );
  final AuthPage authPage = AuthPage();

  Future<String> getUserId() async {
    //todo make real user id
    return Future.value("c9e3c74e-9c89-475d-8115-dbc26ab81c2e");
  }

  Future<String> signUp(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      ///INSERT GAME QUIZ
      var response = await hasuraConnect.mutation(
        authPage.signUp(
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        ),
      );

      return response['data']['signUp']['message'];

    } catch (e) {

      log.e("startGameLevel => ${e.toString()}");

      if(e.toString().contains('CREDENTIALS_IS_ALREADY_IN_USE')||e.toString().contains('USER_ACCOUNT_NOT_CREATED')){
        return 'CREDENTIALS_IS_ALREADY_IN_USE';
      }

      rethrow;
    }
  }

  Future<Tokens> signIn({required String phoneNumber, required String password}) async{

    try {
      ///INSERT GAME QUIZ
      var response = await hasuraConnect.mutation(
        authPage.signIn(
          phoneNumber: phoneNumber,
          password: password,
        ),
      );

      Tokens tokens = Tokens.fromJson(response['data']['signIn']['tokens']);

      return tokens;

    } catch (e) {
      log.e("signIn => ${e.toString()}");
      rethrow;
    }
  }

  saveTokens(Tokens tokens) {
    AppHiveBoxes.instance.authBox.put(Constants.tokensKey, tokens);


    print("TOKENNN => ${AppHiveBoxes.instance.authBox.get(Constants.tokensKey)}");
  }
}
