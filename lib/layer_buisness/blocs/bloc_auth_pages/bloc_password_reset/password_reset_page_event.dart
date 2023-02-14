part of 'password_reset_page_bloc.dart';

abstract class PasswordResetPageEvent extends Equatable {
  const PasswordResetPageEvent();
}


 class ResetPasswordEvent extends PasswordResetPageEvent {

  final String phoneNumber;
  final String newPassword;

  const ResetPasswordEvent( {required this.phoneNumber,required this.newPassword,});

  @override
  List<Object?> get props => [phoneNumber,newPassword];
}
