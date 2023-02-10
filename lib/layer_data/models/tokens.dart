import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'tokens.g.dart';

@HiveType(typeId: 0)
class Tokens extends Equatable {

  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String refreshToken;

  const Tokens({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
  ];

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
    );
  }
//

}
