part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}


 class LoadHomePageEvent extends HomePageEvent {
  const LoadHomePageEvent();

  @override
  List<Object?> get props => [];
}
