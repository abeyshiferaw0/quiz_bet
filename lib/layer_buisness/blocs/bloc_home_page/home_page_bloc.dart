import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:quiz_bet/layer_data/models/home_page_data.dart';
import 'package:quiz_bet/layer_data/repositories/repository_category_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_home_page.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final log = Logger();
  final HomePageRepository homePageRepository;

  HomePageBloc({required this.homePageRepository}) : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) async {
      if (event is LoadHomePageEvent) {
        ///EMIT LOADING
        emit(HomePageLoading());

        try {
          HomePageData homePageData = await homePageRepository.getHomeData();

          ///EMIT LOADED
          emit(
            HomePageLoaded(homePageData: homePageData),
          );
        } catch (e) {
          emit(
            HomePageLoadingError(
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
