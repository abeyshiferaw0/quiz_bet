import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/profile_page_data.dart';
import 'package:quiz_bet/layer_data/repositories/repository_profile_page.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {

  final log = Logger();
  final ProfilePageRepository profilePageRepository;

  ProfilePageBloc({required this.profilePageRepository}) : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) async{

      if (event is LoadProfilePageEvent) {


        ///EMIT LOADING
        emit(ProfilePageLoading());

        try {
          ProfilePageData profilePageData = await profilePageRepository.getProfileData();

          ///EMIT LOADED
          emit(
            ProfilePageLoaded(profilePageData: profilePageData),
          );
        } catch (e) {
          emit(
            ProfilePageLoadingFailed(
              error: e.toString(),
            ),
          );
        }
      } else {
        throw 'event not known';
      }

    });
  }
}
