part of 'forgot_password_page_bloc.dart';

abstract class ForgotPasswordPageState extends Equatable {
  const ForgotPasswordPageState();
}

class ForgotPasswordPageInitial extends ForgotPasswordPageState {
  @override
  List<Object> get props => [];
}


class ForgotPasswordLoadingState extends ForgotPasswordPageState {
  @override
  List<Object> get props => [];
}


class ForgotPasswordLoadingErrorState extends ForgotPasswordPageState {

  final String error;

  const ForgotPasswordLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}


class ForgotPasswordLoadedState extends ForgotPasswordPageState {
  @override
  List<Object> get props => [];
}
