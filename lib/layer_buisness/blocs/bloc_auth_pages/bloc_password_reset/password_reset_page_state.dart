part of 'password_reset_page_bloc.dart';

abstract class PasswordResetPageState extends Equatable {
  const PasswordResetPageState();
}

class PasswordResetPageInitial extends PasswordResetPageState {
  @override
  List<Object> get props => [];
}


class PasswordResetLoadingState extends PasswordResetPageState {
  @override
  List<Object> get props => [];
}


class PasswordResetLoadingErrorState extends PasswordResetPageState {

  final String error;

  const PasswordResetLoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}


class PasswordResetLoadedState extends PasswordResetPageState {
  @override
  List<Object> get props => [];
}
