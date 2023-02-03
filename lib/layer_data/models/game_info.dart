import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';

class GameInfo extends Equatable {
  final String quizId;
  final Category category;
  final List<GameLevel> levels;

  const GameInfo({
    required this.quizId,
    required this.category,
    required this.levels,
  });

  @override
  List<Object?> get props => [
        quizId,
        category,
        levels,
      ];

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      quizId: json["quizId"],
      category: Category.fromJson(json["category"]),
      levels: (json["levels"] as List)
          .map((level) => GameLevel.fromJson(level))
          .toList(),
    );
  }
//
}
