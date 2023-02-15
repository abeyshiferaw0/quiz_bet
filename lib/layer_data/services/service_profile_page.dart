import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/config/token_interceptor.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_profile_page.dart';
import 'package:quiz_bet/layer_data/models/profile_page_data.dart';
import 'package:quiz_bet/layer_data/models/user.dart';

class ProfilePageService {
  final log = Logger();

  //final TokenInterceptor tokenInterceptor = TokenInterceptor();
  final HasuraConnect hasuraConnect = HasuraConnect(
    Constants.hasuraUrl,
    interceptors: [TokenInterceptor()],
  );

  final GqlProfilePage gqlProfilePage = GqlProfilePage();

  Future<ProfilePageData> getProfileData() async {

    late int balance;
    late User user;

    try {
      ///GET WALLET DATA
      var response = await hasuraConnect.mutation(
        gqlProfilePage.getWalletData(),
      );

      ///PARSE AND ASSIGN VALUES
      balance = response['data']['getWallet']['balance'];

      user = AppHiveBoxes.instance.authBox.get(Constants.userKey) as User;

      return ProfilePageData(
        user: user,
        balance: balance,
      );
    } catch (e) {
      log.e("startGameLevel => ${e.toString()}");
      rethrow;
    }
  }
}
