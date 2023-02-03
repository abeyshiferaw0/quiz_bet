import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/game_question_choice.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class GameQuestion extends Equatable {
  final String id;
  final NameJson question;
  final String hint;
  final bool isActive;
  final int maxTimeInSec;
  final GameQuestionChoice choice;

  const GameQuestion({
    required this.id,
    required this.question,
    required  this.hint,
    required this.isActive,
    required this.maxTimeInSec,
    required this.choice,
  });

  @override
  List<Object?> get props => [
        id,
        question,
        hint,
        isActive,
        maxTimeInSec,
        choice,
      ];

  factory GameQuestion.fromJson(Map<String, dynamic> json) {
    return GameQuestion(
      id: json["id"],
      question: NameJson.fromJson(json["question_json"]),
      hint: json["hint"],
      isActive: json["active"],
      maxTimeInSec: json["max_time_in_seconds"],
      choice: GameQuestionChoice.fromJson(json["quizQuestionChoice"]),
    );
  }
//

}
