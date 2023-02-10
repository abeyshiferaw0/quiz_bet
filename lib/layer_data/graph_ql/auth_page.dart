import 'package:quiz_bet/layer_data/models/game_level.dart';

class AuthPage {
  String signUp(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password}) {
    return """
        mutation signUp {
          signUp(name:"$name",password:"$password",email:"$email",phoneNumber:"$phoneNumber"){
            message
          }
        }
    """;
  }

  String signIn({required String password, required String phoneNumber}) {
    return """
          mutation MyMutation2 {
              signIn(password:"123321",phoneNumber:"123456"){
                tokens{
                  access_token
                  refresh_token
                }
            }
          }
    """;
  }
}
