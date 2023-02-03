import 'package:equatable/equatable.dart';

class NameJson extends Equatable {
  final String nameAm;
  final String nameEn;

  const NameJson({required this.nameAm, required this.nameEn});

  @override
  List<Object?> get props => [
        nameAm,
        nameEn,
      ];

  factory NameJson.fromJson(Map<String, dynamic> json) {
    return NameJson(
      nameAm: json["am"],
      nameEn: json["en"],
    );
  }
//

}
