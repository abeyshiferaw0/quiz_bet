part of 'sign_up_page_bloc.dart';

abstract class SignUpPageState extends Equatable {
  const SignUpPageState();
}

class SignUpPageInitial extends SignUpPageState {
  @override
  List<Object> get props => [];
}


class SignUpLoadingState extends SignUpPageState {
  @override
  List<Object> get props => [];
}

class SignUpAccountExistsState extends SignUpPageState {
  @override
  List<Object> get props => [];
}


class SignUpLoadingErrorState extends SignUpPageState {

  final String error;

  SignUpLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class SignUpLoadedState extends SignUpPageState {
  @override
  List<Object> get props => [];
}