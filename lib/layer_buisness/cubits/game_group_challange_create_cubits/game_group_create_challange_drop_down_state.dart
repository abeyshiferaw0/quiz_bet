part of 'game_group_create_challange_drop_down_cubit.dart';

abstract class GameGroupCreateChallangeDropDownState extends Equatable {
  const GameGroupCreateChallangeDropDownState();
}

class GameGroupCreateChallangeDropDownInitial extends GameGroupCreateChallangeDropDownState {
  @override
  List<Object> get props => [];
}

class GameGroupCreateChallangeDropDownOnCategorySelected extends GameGroupCreateChallangeDropDownState {

  final Category category;

  GameGroupCreateChallangeDropDownOnCategorySelected({required this.category});

  @override
  List<Object> get props => [category];
}
