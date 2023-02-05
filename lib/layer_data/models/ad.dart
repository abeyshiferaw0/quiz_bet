import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';
import 'package:quiz_bet/layer_data/models/network_image.dart';

class Ad extends Equatable {
  final String id;
  final NameJson title;
  final NameJson description;
  final NetworkImage image;


  const Ad({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    image,
  ];

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json["id"],
      title: NameJson.fromJson(json["title"]),
      description:  NameJson.fromJson(json["description"]),
      image: NetworkImage.fromJson(json["image"]),
    );
  }
//

}
