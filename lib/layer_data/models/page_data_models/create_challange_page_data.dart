import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/ad.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/category_trending.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/user.dart';

class CreateChallangePageData extends Equatable {
  final List<Category> categories;
final double walletBalance;

  const CreateChallangePageData({
    required this.categories,
    required this.walletBalance,
  });

  @override
  List<Object?> get props => [
    categories,
    walletBalance
      ];
}
