import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';

part 'forgot_password_page_event.dart';
part 'forgot_password_page_state.dart';

class ForgotPasswordPageBloc extends Bloc<ForgotPasswordPageEvent, ForgotPasswordPageState> {

  final log = Logger();
  final AuthPageRepository authPageRepository;


  ForgotPasswordPageBloc({required this.authPageRepository}) : super(ForgotPasswordPageInitial()) {
    on<ForgotPasswordPageEvent>((event, emit) async{


      if (event is ForgotPasswordEvent) {
        emit(
          ForgotPasswordLoadingState(),
        );

        try {
         await authPageRepository.forgotPassword(
            phoneNumber: event.phoneNumber,
          );

          emit(
            ForgotPasswordLoadedState(),
          );
        } catch (e) {
          emit(
            ForgotPasswordLoadingErrorState(error: e.toString()),
          );
        }
      } else {
        ///EMIT LOADING ERROR
        throw 'event not known';
      }

    });
  }
}
