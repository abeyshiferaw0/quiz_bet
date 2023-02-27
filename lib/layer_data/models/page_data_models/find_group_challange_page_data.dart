import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/ad.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/category_trending.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/user.dart';

class FindGroupChallangePageData extends Equatable {
  final Category category;
  final GameLevel gameLevel;
  final double amountPerPerson;
  final double walletBalance;

  const FindGroupChallangePageData({
    required this.category,
    required this.gameLevel,
    required this.amountPerPerson,
    required this.walletBalance,
  });

  @override
  List<Object?> get props => [
        category,
    gameLevel,
        walletBalance,
        amountPerPerson,
      ];

  factory FindGroupChallangePageData.fromJson(Map<String, dynamic> json) {
    return FindGroupChallangePageData(
      category: Category.fromJson(json["category"]),
      gameLevel: GameLevel.fromJson(json["category"]),
      amountPerPerson: double.parse(json["amountPerPerson"]),
      walletBalance: double.parse(json["walletBalance"]),
    );
  }
//

}
