part of 'category_page_bloc.dart';

abstract class CategoryPageState extends Equatable {
  const CategoryPageState();
}

class CategoryPageInitial extends CategoryPageState {
  @override
  List<Object> get props => [];
}

class CategoryPageLoading extends CategoryPageState {
  @override
  List<Object> get props => [];
}

class CategoryPageLoadingError extends CategoryPageState {
  final String error;

  const CategoryPageLoadingError({required this.error});

  @override
  List<Object> get props => [error];
}

class CategoryPageLoaded extends CategoryPageState {
  final List<Category> categoryList;

  const CategoryPageLoaded({required this.categoryList});

  @override
  List<Object> get props => [categoryList];
}