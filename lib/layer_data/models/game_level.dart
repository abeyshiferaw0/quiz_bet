import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_question.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class GameLevel extends Equatable {
  final String id;
  final NameJson name;
  final int key;
  final double odd;
  final List<GameQuestion> questions;

  const GameLevel({
    required this.id,
    required this.name,
    required this.key,
    required this.odd,
    required this.questions,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        key,
        odd,
        questions,
      ];

  factory GameLevel.fromJson(Map<String, dynamic> json) {
    return GameLevel(
      id: json["id"],
      name: NameJson.fromJson(json["name_json"]),
      key: json["level_key"],
      odd: json["odds"],
      questions: (json["questions"] as List).map((question) => GameQuestion.fromJson(question)).toList(),
    );
  }
//

}
