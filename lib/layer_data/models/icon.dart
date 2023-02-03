import 'package:equatable/equatable.dart';

class Icon extends Equatable {
  final String id;
  final String name;

  const Icon({required this.id, required this.name});

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  factory Icon.fromJson(Map<String, dynamic> json) {
    return Icon(
      id: json["id"],
      name: json["name"],
    );
  }
//

}
