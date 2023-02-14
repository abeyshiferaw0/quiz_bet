part of 'forgot_password_page_bloc.dart';

abstract class ForgotPasswordPageEvent extends Equatable {
  const ForgotPasswordPageEvent();
}


class ForgotPasswordEvent extends ForgotPasswordPageEvent {
  final String phoneNumber;

  const ForgotPasswordEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    phoneNumber,
  ];
}
