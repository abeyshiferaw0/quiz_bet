import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_category_page/category_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_checker/game_checker_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_start/game_start_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_gmae_history_saver/game_history_saver_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/game_player_page/game_player_bloc.dart';
import 'package:quiz_bet/layer_buisness/cubits/game_start_info_cubit/game_start_info_cubit.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_category_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/layer_data/services/service_category_page.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';
import 'package:quiz_bet/layer_presentation/screen_add_members/add_member_page.dart';
import 'package:quiz_bet/layer_presentation/screen_all_categories/all_categories_page.dart';
import 'package:quiz_bet/layer_presentation/screen_create_challange/create_challange_page.dart';
import 'package:quiz_bet/layer_presentation/screen_create_group/create_group_page.dart';
import 'package:quiz_bet/layer_presentation/screen_friend_request_page/all_frend_request_page.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/game_player_page.dart';
import 'package:quiz_bet/layer_presentation/screen_game_start_countdown_page/game_start_countdown_page.dart';
import 'package:quiz_bet/layer_presentation/screen_group_detail_page/group_detail_page.dart';
import 'package:quiz_bet/layer_presentation/screen_main_page/main_page.dart';
import 'package:quiz_bet/layer_presentation/screen_profile_page/profile_page.dart';

import '../layer_presentation/screen_game_player_info_page/game_player_info_page.dart';

class ScreenArguments {
  final Map<String, dynamic> data;

  ScreenArguments({required this.data});
}

class AppRouterPaths {
  static const String splashRoute = '/';
  static const String gamePlayerPage = '/game_player_page';
  static const String gamePlayerInfoPage = '/game_player_info_page';
  static const String gameStartCountDownPage = '/game_start_countdown_page';
  static const String profilePage = '/profile_page';
  static const String allCategoriesPage = '/all_categories_page';
  static const String friendRequestPage = '/friend_request_page';
  static const String groupDetailPage = '/group_detail_page';
  static const String createChallenge = '/create_challenge';
  static const String createGroup = '/create_group';
  static const String addMember = '/add_member';
}

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    //BUILDER
    WidgetBuilder builder;
    //ROUTERS PATH SWITCH
    switch (settings.name) {
      case AppRouterPaths.splashRoute:
        builder = (_) => const MainPage();
        break;
      case AppRouterPaths.gamePlayerInfoPage:
        final args = settings.arguments as ScreenArguments;

        builder = (_) => MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => GamePageRepository(
                    service: GamePageService(),
                  ),
                ),
                RepositoryProvider(
                  create: (context) => AuthPageRepository(
                    service: AuthPageService(),
                  ),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => GameStartBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                      authPageRepository: context.read<AuthPageRepository>(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => GameStartInfoCubit(),
                  ),
                ],
                child: GamePlayerInfoPage(
                  categoryId: args.data['categoryId'],
                ),
              ),
            );

        break;
      case AppRouterPaths.gamePlayerPage:
        final args = settings.arguments as ScreenArguments;
        builder = (_) => MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) =>
                      GamePageRepository(service: GamePageService()),
                ),
                RepositoryProvider(
                  create: (context) =>
                      AuthPageRepository(service: AuthPageService()),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => GamePlayerBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                      authPageRepository: context.read<AuthPageRepository>(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => GameCheckerBloc(),
                  ),
                  BlocProvider(
                    create: (context) => GameHistorySaverBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                    ),
                  ),
                ],
                child: GamePlayerPage(
                  gameInfo: args.data['gameInfo'],
                  amountToBet: args.data['amountToBet'],
                  vatPer: args.data['vatPer'],
                ),
              ),
            );
        break;
      case AppRouterPaths.gameStartCountDownPage:
        final args = settings.arguments as ScreenArguments;
        builder = (_) => GameStartCountDownPage(
              gameInfo: args.data['gameInfo'],
              amountToBet: args.data['amountToBet'],
              vatPer: args.data['vatPer'],
            );
        break;
      case AppRouterPaths.profilePage:
        builder = (_) => const ProfilePage();
        break;
      case AppRouterPaths.allCategoriesPage:
        builder = (_) => RepositoryProvider(
              create: (context) => CategoryPageRepository(
                service: CategoryPageService(),
              ),
              child: BlocProvider(
                create: (context) => CategoryPageBloc(
                  categoryPageRepository:
                      context.read<CategoryPageRepository>(),
                ),
                child: const AllCategoriesPage(),
              ),
            );
        break;
      case AppRouterPaths.friendRequestPage:
        builder = (_) => const FriendRequestPage();
        break;
      case AppRouterPaths.groupDetailPage:
        builder = (_) => const GroupDetailPage();
        break;
      case AppRouterPaths.createChallenge:
        builder = (_) => const CreateChallengePage();
        break;
      case AppRouterPaths.createGroup:
        builder = (_) => const CreateAGroupPage();
        break;
      case AppRouterPaths.addMember:
        builder = (_) => const AddMembersPage();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    //BUILDER  WITH ROUTERS
    return CupertinoPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
