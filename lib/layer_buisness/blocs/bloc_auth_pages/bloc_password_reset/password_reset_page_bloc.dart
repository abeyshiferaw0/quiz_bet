import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';

part 'password_reset_page_event.dart';
part 'password_reset_page_state.dart';

class PasswordResetPageBloc extends Bloc<PasswordResetPageEvent, PasswordResetPageState> {

  final log = Logger();
  final AuthPageRepository authPageRepository;


  PasswordResetPageBloc({required this.authPageRepository}) : super(PasswordResetPageInitial()) {
    on<PasswordResetPageEvent>((event, emit) async{

      // PasswordResetLoadingState
      // PasswordResetLoadingErrorState
      // PasswordResetLoadedState

      if (event is ResetPasswordEvent) {
        emit(
          PasswordResetLoadingState(),
        );

        try {
          await authPageRepository.resetPassword(
            phoneNumber: event.phoneNumber,
            newPassword:event.newPassword,
            otp: '1234',
          );


          emit(
            PasswordResetLoadedState(),
          );
        } catch (e) {
          emit(
            PasswordResetLoadingErrorState(error: e.toString()),
          );
        }
      } else {
        ///EMIT LOADING ERROR
        throw 'event not known';
      }

    });
  }

}
