import 'package:logger/logger.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/graph_ql/gql_profile_page.dart';
import 'package:quiz_bet/layer_data/models/page_data_models/profile_page_data.dart';
import 'package:quiz_bet/layer_data/models/user.dart';
import 'package:quiz_bet/layer_data/services/base_hasura_service.dart';

class ProfilePageService {
  final log = Logger();

  BaseHasuraService baseHasuraService = BaseHasuraService();

  final GqlProfilePage gqlProfilePage = GqlProfilePage();

  Future<ProfilePageData> getProfileData() async {

    late int balance;
    late User user;

    try {
      ///GET WALLET DATA
      var response = await baseHasuraService.mutation(
        document: gqlProfilePage.getWalletData(),
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
