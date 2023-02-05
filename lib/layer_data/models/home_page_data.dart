import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/ad.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/models/category_trending.dart';

class HomePageData extends Equatable {
  final List<Category> categoryList;
  final List<Ad> ads;
  final List<CategoryTrending> trendingCategories;

  const HomePageData(
      {required this.ads,
      required this.categoryList,
      required this.trendingCategories});

  @override
  List<Object?> get props => [
        ads,
        categoryList,
        trendingCategories,
      ];
}
