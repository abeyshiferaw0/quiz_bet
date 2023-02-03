part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoadingError extends HomePageState {
  final String error;

  const HomePageLoadingError({required this.error});

  @override
  List<Object> get props => [error];
}

class HomePageLoaded extends HomePageState {
  final HomePageData homePageData;

  const HomePageLoaded({required this.homePageData});

  @override
  List<Object> get props => [homePageData];
}
