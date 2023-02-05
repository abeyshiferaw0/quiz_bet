import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/icon.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class NetworkImage extends Equatable {
  final String id;
  final String smallImage;
  final String mediumImage;
  final String largeImage;
  

  const NetworkImage({
    required this.id,
    required this.smallImage,
    required this.mediumImage,
    required this.largeImage,
  });

  @override
  List<Object?> get props => [
    id,
    smallImage,
    mediumImage,
    largeImage,
  ];

  factory NetworkImage.fromJson(Map<String, dynamic> json) {
    return NetworkImage(
      id: json["id"],
      smallImage: json["small_image"],
      mediumImage: json["medium_image"],
      largeImage: json["large_image"],
    );
  }
//

}
