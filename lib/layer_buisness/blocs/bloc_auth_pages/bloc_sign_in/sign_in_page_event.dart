part of 'sign_in_page_bloc.dart';

abstract class SignInPageEvent extends Equatable {
  const SignInPageEvent();
}

class SignInEvent extends SignInPageEvent {
  final String phoneNumber;
  final String password;

  const SignInEvent({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
      ];
}
