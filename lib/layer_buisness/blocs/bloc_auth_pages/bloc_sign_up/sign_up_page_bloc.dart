import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';

part 'sign_up_page_event.dart';
part 'sign_up_page_state.dart';

class SignUpPageBloc extends Bloc<SignUpPageEvent, SignUpPageState> {
  final log = Logger();
  final AuthPageRepository authPageRepository;

  SignUpPageBloc({required this.authPageRepository})
      : super(SignUpPageInitial()) {
    on<SignUpPageEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(
          SignUpLoadingState(),
        );

        try {
        String message = await authPageRepository.signUp(
            name: event.name,
            phoneNumber: event.phoneNumber,
            email: event.email,
            password: event.password,
          );



        if(message.contains('CREDENTIALS_IS_ALREADY_IN_USE')||message.contains('USER_ACCOUNT_NOT_CREATED')){
          emit(
            SignUpAccountExistsState(),
          );
        }else{
          if(message == 'ACCOUNT_CREATED'){
            emit(
              SignUpLoadedState(),
            );
          }else{
            emit(
              SignUpLoadingErrorState(error: 'sign up error'),
            );
          }
        }



        } catch (e) {

          emit(
            SignUpLoadingErrorState(error: e.toString()),
          );

        }
      } else {
        ///EMIT LOADING ERROR
        throw 'event not known';
      }
    });
  }
}
