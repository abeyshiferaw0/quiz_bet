import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/ad.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/category_trending.dart';
import 'package:quiz_bet/layer_data/models/user.dart';

class ProfilePageData extends Equatable {
  final User user;
  final int balance;

  const ProfilePageData({
    required this.user,
    required this.balance,
  });

  @override
  List<Object?> get props => [
    user,
    balance,
      ];
}
