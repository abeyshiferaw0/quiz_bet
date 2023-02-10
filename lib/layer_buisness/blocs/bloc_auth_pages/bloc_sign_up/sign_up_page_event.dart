part of 'sign_up_page_bloc.dart';

abstract class SignUpPageEvent extends Equatable {
  const SignUpPageEvent();
}

class SignUpEvent extends SignUpPageEvent {
  final String name;
  final String phoneNumber;
  final String password;
  final String email;

  SignUpEvent(
      {required this.name,
      required this.phoneNumber,
      required this.password,
      required this.email});

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        password,
        email,
      ];
}
