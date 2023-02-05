import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/icon.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';
import 'package:quiz_bet/layer_data/models/network_image.dart';

class CategoryTrending extends Equatable {
  final String categoryId;
  final NetworkImage image;
  final NameJson name;
  final Icon icon;
  final int levelsCount;
  final int questionsCount;
  final double totalOdds;

  CategoryTrending({
    required this.categoryId,
  required this.image,
  required this.name,
  required this.icon,
  required this.levelsCount,
  required this.questionsCount,
  required this.totalOdds,
  });

  @override
  List<Object?> get props => [
    categoryId,
    image,
    name,
    icon,
    levelsCount,
    questionsCount,
    totalOdds,
      ];

  factory CategoryTrending.fromJson(Map<String, dynamic> json) {

   print("jsonjson => ${json}");

    return CategoryTrending(
      categoryId: json["categoryList"]["id"],
      image: NetworkImage.fromJson(json["image"]),
      name: NameJson.fromJson(json["categoryList"]["name_json"]),
      icon: Icon.fromJson(json["categoryList"]["icon"],),
      levelsCount: json["categoryList"]["levels_aggregate"]["aggregate"]["count"],
      questionsCount: (json["categoryList"]["levels"] as List).reduce((e,ee) => e["questions_aggregate"]["aggregate"]["count"]+ee["questions_aggregate"]["aggregate"]["count"]),
      totalOdds: (json["categoryList"]["levels"] as List).reduce((e,ee) => e["odds"]+ee["odds"]),
    );
  }
//

}
