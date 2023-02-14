import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';
import 'package:quiz_bet/layer_data/models/network_image.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/layer_data/models/user.dart';

class SignInData extends Equatable {
  final Tokens tokens;
  final User user;


  const SignInData({
    required this.tokens,
    required this.user,
  });

  @override
  List<Object?> get props => [
    tokens,
    user,
  ];


}
