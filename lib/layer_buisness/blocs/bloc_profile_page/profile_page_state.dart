part of 'profile_page_bloc.dart';

abstract class ProfilePageState extends Equatable {
  const ProfilePageState();
}

class ProfilePageInitial extends ProfilePageState {
  @override
  List<Object> get props => [];
}

class ProfilePageLoading extends ProfilePageState {
  @override
  List<Object> get props => [];
}

class ProfilePageLoadingFailed extends ProfilePageState {
  
  final String error;
  
  ProfilePageLoadingFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class ProfilePageLoaded extends ProfilePageState {

  final ProfilePageData profilePageData;


  ProfilePageLoaded({required this.profilePageData});

  @override
  List<Object> get props => [profilePageData];
}
