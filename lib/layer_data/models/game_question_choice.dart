import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/models/name_json.dart';

class GameQuestionChoice extends Equatable {
  final String id;
  final List<Choice> choices;
  final String correctOption;
  late Choice? _usersAnswer;


   GameQuestionChoice(
      {required this.id, required this.choices, required this.correctOption});

  @override
  List<Object?> get props => [
        id,
        choices,
        correctOption,

      ];


  Choice? get usersAnswer => _usersAnswer;

  set usersAnswer(Choice? value) {
    _usersAnswer = value;
  }

  factory GameQuestionChoice.fromJson(Map<String, dynamic> json) {
    return GameQuestionChoice(
      id: json["id"],
      choices: (json['choices'] as List)
          .map((choice) => Choice.fromJson(choice))
          .toList(),
      correctOption: json["correct"],
    );
  }
//

}

class Choice extends Equatable {
  final String value;
  final String option;

  const Choice({required this.value, required this.option});

  @override
  List<Object?> get props => [
        value,
        option,
      ];

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      value: json["value"],
      option: json["option"],
    );
  }
//

}
