import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';

class GameInitialInfo extends Equatable {

  final Category category;
  final List<GameLevel> levels;

  const GameInitialInfo({
    required this.category,
    required this.levels,
  });

  @override
  List<Object?> get props => [
        category,
        levels,
      ];

  factory GameInitialInfo.fromJson(Map<String, dynamic> json) {
    return GameInitialInfo(
      category: Category.fromJson(json["category"]),
      levels: (json["levels"] as List)
          .map((level) => GameLevel.fromJson(level))
          .toList(),
    );
  }
//
}
