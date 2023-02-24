import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_bet/layer_data/models/category.dart';

part 'game_group_create_challange_drop_down_state.dart';

class GameGroupCreateChallangeDropDownCubit extends Cubit<GameGroupCreateChallangeDropDownState> {
  GameGroupCreateChallangeDropDownCubit() : super(GameGroupCreateChallangeDropDownInitial());

  categorySelected(Category category){
    emit(GameGroupCreateChallangeDropDownOnCategorySelected(category: category));
  }

}
