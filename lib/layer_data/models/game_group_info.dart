import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';

class GameGroupInfo extends Equatable {
  final String groupQuizId;
  final Category category;
  final List<GameLevel> levels;
  final double amountPerPerson;
  final int vatPer;

  const GameGroupInfo({
    required this.groupQuizId,
    required this.category,
    required this.levels,
    required this.amountPerPerson,
    required this.vatPer,
  });

  @override
  List<Object?> get props => [
    groupQuizId,
        category,
        levels,
    amountPerPerson,
    vatPer
      ];


//
}
