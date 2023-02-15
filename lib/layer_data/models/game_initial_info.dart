import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';

class GameInitialInfo extends Equatable {

  final Category category;
  final List<GameLevel> levels;
  final double vatPercentage;
  final double balance;

  const GameInitialInfo( {
    required this.vatPercentage,
    required this.category,
    required this.levels,
    required this.balance,
  });

  @override
  List<Object?> get props => [
    vatPercentage,
        category,
        levels,balance,
      ];

  factory GameInitialInfo.fromJson(Map<String, dynamic> json) {
    return GameInitialInfo(
        vatPercentage:json[""],
        balance:json[""],
      category: Category.fromJson(json["category"]),
      levels: (json["levels"] as List)
          .map((level) => GameLevel.fromJson(level))
          .toList(),
    );
  }
//
}
