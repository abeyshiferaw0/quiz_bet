import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/repositories/repository_category_page.dart';

part 'category_page_event.dart';
part 'category_page_state.dart';

class CategoryPageBloc extends Bloc<CategoryPageEvent, CategoryPageState> {
  final log = Logger();
  final CategoryPageRepository categoryPageRepository;

  CategoryPageBloc({required this.categoryPageRepository})
      : super(CategoryPageInitial()) {
    on<CategoryPageEvent>((event, emit) async {
      if (event is GetAllCategoryEvent) {
        ///EMIT LOADING
        emit(CategoryPageLoading());

        try {
          List<Category> categoryList =
              await categoryPageRepository.getAllCategories();

          ///EMIT LOADED
          emit(
            CategoryPageLoaded(categoryList: categoryList),
          );
        } catch (e) {
          CategoryPageLoadingError(
            error: e.toString(),
          );
        }
      } else {
        ///EMIT LOADING ERROR
        emit(
          const CategoryPageLoadingError(error: 'Event not known'),
        );
      }
    });
  }
}
