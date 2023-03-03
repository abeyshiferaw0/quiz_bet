import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class GameGroupActivePlayer extends Equatable {
  final String id;
  final String quizGroupId;
  final bool isActive;
  final String userId;
  final String userName;

  const GameGroupActivePlayer({
    required this.id,
    required this.quizGroupId,
    required this.isActive,
    required this.userId,
    required this.userName,
  });

  @override
  List<Object?> get props => [
    id,
    quizGroupId,
    isActive,
    userId,
    userName,
      ];

  factory GameGroupActivePlayer.fromJson(Map<String, dynamic> json) {
    return GameGroupActivePlayer(
      id: json["id"],
      quizGroupId: json["quiz_group_id"],
      isActive: json["isActive"],
      userId: json["user_id"],
      userName: json["user"]['user_name'],

    );
  }
//

}
