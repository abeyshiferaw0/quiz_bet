import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';
import 'package:quiz_bet/layer_data/models/network_image.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String languageCode;
  @HiveField(4)
  final List<String> role;

  const User({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.languageCode,
    required this.role,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        languageCode,
        role,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      languageCode: json["langCode"],
      role: (json["role"] as List).map((e) => e as String).toList(),
    );
  }
//

}
