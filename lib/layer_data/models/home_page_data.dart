import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';

class HomePageData extends Equatable {
  final List<Category> categoryList;

  const HomePageData({
    required this.categoryList,
  });

  @override
  List<Object?> get props => [categoryList];
}
