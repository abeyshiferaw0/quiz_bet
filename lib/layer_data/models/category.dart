import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/icon.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class Category extends Equatable {
  final String id;
  final NameJson name;
  final List<GameLevel>? gameLevels;
  final NameJson description;
  final Icon icon;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.gameLevels,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        gameLevels,
        icon,
      ];

  factory Category.fromJson(Map<String, dynamic> json) {

    print("LELESSS=> ${json['levels']}");

    return Category(
      id: json["id"],
      name: NameJson.fromJson(json["name_json"]),
      description: NameJson.fromJson(json["description_json"]),
      icon: Icon.fromJson(json["icon"]),
      gameLevels: json['levels'] != null
          ? (json['levels'] as List)
              .map((level) => GameLevel.fromJson(level))
              .toList()
          : null,
    );
  }
//

}
