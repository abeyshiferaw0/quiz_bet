import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';

class GameGroupInfo extends Equatable {
  final String groupQuizId;
  final Category category;
  final List<GameLevel> levels;

  const GameGroupInfo({
    required this.groupQuizId,
    required this.category,
    required this.levels,
  });

  @override
  List<Object?> get props => [
    groupQuizId,
        category,
        levels,
      ];

  factory GameGroupInfo.fromJson(Map<String, dynamic> json) {
    return GameGroupInfo(
      groupQuizId: json["groupQuizId"],
      category: Category.fromJson(json["category"]),
      levels: (json["levels"] as List)
          .map((level) => GameLevel.fromJson(level))
          .toList(),
    );
  }
//
}
