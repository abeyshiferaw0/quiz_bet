part of 'sign_in_page_bloc.dart';

abstract class SignInPageState extends Equatable {
  const SignInPageState();
}

class SignInPageInitial extends SignInPageState {
  @override
  List<Object> get props => [];
}

class SignInPageLoadingState extends SignInPageState {
  @override
  List<Object> get props => [];
}

class SignInPageLoadingErrorState extends SignInPageState {
  final String error;

  const SignInPageLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class SignInPageLoadedState extends SignInPageState {
  @override
  List<Object> get props => [];
}
