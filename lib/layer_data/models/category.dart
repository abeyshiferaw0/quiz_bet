import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/icon.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class Category extends Equatable {
  final String id;
  final NameJson name;
  final NameJson description;
  final Icon icon;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        icon,
      ];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: NameJson.fromJson(json["name_json"]),
      description: NameJson.fromJson(json["description_json"]),
      icon: Icon.fromJson(json["icon"]),
    );
  }
//

}
