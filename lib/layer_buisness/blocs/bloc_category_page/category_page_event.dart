part of 'category_page_bloc.dart';

abstract class CategoryPageEvent extends Equatable {
  const CategoryPageEvent();
}


class GetAllCategoryEvent extends CategoryPageEvent {
  @override
  List<Object?> get props => [];
}
