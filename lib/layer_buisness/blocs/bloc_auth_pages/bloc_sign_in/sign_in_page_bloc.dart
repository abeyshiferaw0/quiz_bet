import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/sign_in_data.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';

part 'sign_in_page_event.dart';
part 'sign_in_page_state.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  final log = Logger();
  final AuthPageRepository authPageRepository;

  SignInPageBloc({required this.authPageRepository})
      : super(SignInPageInitial()) {
    on<SignInPageEvent>((event, emit) async {
      if (event is SignInEvent) {
        emit(
          SignInPageLoadingState(),
        );


        try {
          SignInData signInData = await authPageRepository.signIn(
            phoneNumber: event.phoneNumber,
            password: event.password,
          );

          ///SAVE ACCESS , REFRESH TOKENS AND USER DATA
          authPageRepository.saveTokens(signInData.tokens);
          authPageRepository.saveUser(signInData.user);

          emit(
            SignInPageLoadedState(),
          );
        } catch (e) {
          emit(
            SignInPageLoadingErrorState(error: e.toString()),
          );
        }
      } else {
        ///EMIT LOADING ERROR
        throw 'event not known';
      }
    });
  }
}
