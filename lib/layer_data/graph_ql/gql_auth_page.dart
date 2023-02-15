import 'package:quiz_bet/layer_data/models/game_level.dart';

class GqlAuthPage {
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
              signIn(password:"$password",phoneNumber:"$phoneNumber"){
                tokens{
                  access_token
                  refresh_token
                }
                 data{
                    id
                    email
                    phoneNumber
                    langCode
                    role
                 }
            }
          }
    """;
  }

  String forgotPassword({required String phoneNumber}) {
    return """
       mutation forgotPassword {
         forgetPassword(phoneNumber:"${phoneNumber}"){
           message
         }
       }
    """;
  }

  String resetPassword({required String phoneNumber, required newPassword, required String otp}) {

    print("object ${"""
         mutation MyMutation2 {
           resetPassword(code:"$otp",password:"$newPassword",phoneNumber:"$phoneNumber"){
             message
           }
         }
    """}");

    return """
         mutation MyMutation2 {
           resetPassword(code:"$otp",password:"$newPassword",phoneNumber:"$phoneNumber"){
             message
           }
         }
    """;
  }
}
