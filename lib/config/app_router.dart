import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_forgot_password/forgot_password_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_password_reset/password_reset_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_sign_in/sign_in_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_sign_up/sign_up_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_category_page/category_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_checker/game_checker_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_get_info/game_get_info_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_challange_create/game_group_challange_create_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_challange_finder/game_group_challange_finder_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_create_challange/game_group_create_challange_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_forfit_winner_listner_subscription/game_group_forfit_winner_listner_subscription_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_joined_subscription/game_group_joined_subscription_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_main_page/game_group_main_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_gmae_history_saver/game_history_saver_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_home_page/home_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_profile_page/profile_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/game_player_page/game_player_bloc.dart';
import 'package:quiz_bet/layer_buisness/cubits/game_group_challange_create_cubits/game_group_create_challange_drop_down_cubit.dart';
import 'package:quiz_bet/layer_buisness/cubits/game_start_info_cubit/game_start_info_cubit.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_category_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_home_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_profile_page.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/layer_data/services/service_category_page.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';
import 'package:quiz_bet/layer_data/services/service_home_page.dart';
import 'package:quiz_bet/layer_data/services/service_profile_page.dart';
import 'package:quiz_bet/layer_presentation/screen_add_members/add_member_page.dart';
import 'package:quiz_bet/layer_presentation/screen_all_categories/all_categories_page.dart';
import 'package:quiz_bet/layer_presentation/screen_auth_pages/auth_forgot_pass_page.dart';
import 'package:quiz_bet/layer_presentation/screen_auth_pages/auth_password_reset_page.dart';
import 'package:quiz_bet/layer_presentation/screen_auth_pages/auth_pin_input_page.dart';
import 'package:quiz_bet/layer_presentation/screen_auth_pages/auth_sign_in_page.dart';
import 'package:quiz_bet/layer_presentation/screen_auth_pages/auth_sign_up_page.dart';
import 'package:quiz_bet/layer_presentation/screen_create_challange/create_challange_page.dart';
import 'package:quiz_bet/layer_presentation/screen_create_group/create_group_page.dart';
import 'package:quiz_bet/layer_presentation/screen_friend_request_page/all_frend_request_page.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/group_game_page.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group_start_countdown_page/game_start_group_game_countdown_page.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_page/game_player_page.dart';
import 'package:quiz_bet/layer_presentation/screen_game_start_countdown_page/game_start_countdown_page.dart';
import 'package:quiz_bet/layer_presentation/screen_group_detail_page/group_detail_page.dart';
import 'package:quiz_bet/layer_presentation/screen_join_game/join_game_game_find_page.dart';
import 'package:quiz_bet/layer_presentation/screen_join_game/join_game_qr_scan_page.dart';
import 'package:quiz_bet/layer_presentation/screen_main_page/main_page.dart';
import 'package:quiz_bet/layer_presentation/screen_on_boarding/onboarding_page.dart';
import 'package:quiz_bet/layer_presentation/screen_profile_page/profile_page.dart';
import 'package:quiz_bet/layer_presentation/screen_splash_page/spalsh_page.dart';

import '../layer_presentation/screen_game_player_info_page/game_player_info_page.dart';

class ScreenArguments {
  final Map<String, dynamic> data;

  ScreenArguments({required this.data});
}

class AppRouterPaths {
  static const String splashRoute = '/';
  static const String onBoardingPage = '/on_boarding_page';
  static const String authSignUp = '/auth_sign_up';
  static const String authSignIn = '/auth_sign_in';
  static const String authForgetPass = '/auth_forgot_pass';
  static const String authInputPin = '/auth_input_pin';
  static const String authPasswordReset = '/password_reset';
  static const String mainScreen = 'main_screen';
  static const String gamePlayerPage = '/game_player_page';
  static const String gameGroupPlayerPage = '/game_group_player_page';
  static const String gamePlayerInfoPage = '/game_player_info_page';
  static const String gameStartCountDownPage = '/game_start_countdown_page';
  static const String gameGroupStartCountDownPage =
      '/game_group_start_countdown_page';
  static const String profilePage = '/profile_page';
  static const String allCategoriesPage = '/all_categories_page';
  static const String friendRequestPage = '/friend_request_page';
  static const String groupDetailPage = '/group_detail_page';
  static const String createChallenge = '/create_challenge';
  static const String createGroup = '/create_group';
  static const String addMember = '/add_member';
  static const String joinGameQrScan = '/join_game_qr_scan';
  static const String joinGameFindGameScan = '/join_game_find_game_scan';
}

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    //BUILDER
    WidgetBuilder builder;
    //ROUTERS PATH SWITCH
    switch (settings.name) {
      case AppRouterPaths.splashRoute:
        builder = (_) => const SplashPage();
        break;
      case AppRouterPaths.onBoardingPage:
        builder = (_) => const OnboardingPage();
        break;

      case AppRouterPaths.authSignUp:
        builder = (_) => RepositoryProvider(
              create: (context) => AuthPageRepository(
                service: AuthPageService(),
              ),
              child: BlocProvider(
                create: (context) => SignUpPageBloc(
                  authPageRepository: context.read<AuthPageRepository>(),
                ),
                child: const AuthSignUpPage(),
              ),
            );
        break;
      case AppRouterPaths.authSignIn:
        builder = (_) => RepositoryProvider(
              create: (context) => AuthPageRepository(
                service: AuthPageService(),
              ),
              child: BlocProvider(
                create: (context) => SignInPageBloc(
                  authPageRepository: context.read<AuthPageRepository>(),
                ),
                child: const AuthSignInPage(),
              ),
            );
        break;
      case AppRouterPaths.authForgetPass:
        builder = (_) => RepositoryProvider(
              create: (context) => AuthPageRepository(
                service: AuthPageService(),
              ),
              child: BlocProvider(
                create: (context) => ForgotPasswordPageBloc(
                  authPageRepository: context.read<AuthPageRepository>(),
                ),
                child: const AuthForgotPassPage(),
              ),
            );
        break;
      case AppRouterPaths.authInputPin:
        final args = settings.arguments as ScreenArguments;

        builder = (_) => AuthPinInputPagePage(
              phoneNumber: args.data['phone_number'],
            );

        break;
      case AppRouterPaths.authPasswordReset:
        final args = settings.arguments as ScreenArguments;

        builder = (_) => RepositoryProvider(
              create: (context) => AuthPageRepository(
                service: AuthPageService(),
              ),
              child: BlocProvider(
                create: (context) => PasswordResetPageBloc(
                  authPageRepository: context.read<AuthPageRepository>(),
                ),
                child: AuthPasswordResetPage(
                  phoneNumber: args.data['phone_number'],
                ),
              ),
            );
        break;
      case AppRouterPaths.mainScreen:
        builder = (_) => RepositoryProvider(
              create: (context) =>
                  HomePageRepository(service: HomePageService()),
              child: BlocProvider<HomePageBloc>(
                create: (context) => HomePageBloc(
                  homePageRepository: context.read<HomePageRepository>(),
                ),
                child: const MainPage(),
              ),
            );
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
                    create: (context) => GameStartInfoCubit(),
                  ),
                  BlocProvider(
                    create: (context) => GameGetInfoBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                      authPageRepository: context.read<AuthPageRepository>(),
                    ),
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

      case AppRouterPaths.gameGroupPlayerPage:
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
                    create: (context) =>
                        GameGroupMainPageBloc(args.data['game_group_info']),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GameGroupForfeitWinnerListenerSubscriptionBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                      authPageRepository: context.read<AuthPageRepository>(),
                      gameGroupInfo: args.data['game_group_info'],
                    ),
                  ),
                ],
                child: GroupGamePage(
                  gameGroupInfo: args.data['game_group_info'],
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

      case AppRouterPaths.gameGroupStartCountDownPage:
        final args = settings.arguments as ScreenArguments;
        builder = (_) => GameStartGroupGameCountDownPage(
              gameGroupInfo: args.data['group_game_info'],
            );
        break;
      case AppRouterPaths.profilePage:
        builder = (_) => RepositoryProvider(
              create: (context) =>
                  ProfilePageRepository(service: ProfilePageService()),
              child: BlocProvider(
                create: (context) => ProfilePageBloc(
                    profilePageRepository:
                        context.read<ProfilePageRepository>()),
                child: ProfilePage(),
              ),
            );
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
                    create: (context) => GameGroupCreateChallangeBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                      authPageRepository: context.read<AuthPageRepository>(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GameGroupCreateChallangeDropDownCubit(),
                  ),
                  BlocProvider(
                    create: (context) => GameGroupChallangeCreateBloc(
                      gamePageRepository: context.read<GamePageRepository>(),
                      authPageRepository: context.read<AuthPageRepository>(),
                    ),
                  ),
                ],
                child: CreateChallengePage(),
              ),
            );

        break;
      case AppRouterPaths.createGroup:
        builder = (_) => const CreateAGroupPage();
        break;
      case AppRouterPaths.addMember:
        final args = settings.arguments as ScreenArguments;

        GameGroupInfo gameGroupInfo = args.data['game_group_info'];

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
              child: BlocProvider(
                create: (context) => GameGroupJoinedSubscriptionBloc(
                  quizId: gameGroupInfo.groupQuizId,
                  gamePageRepository: context.read<GamePageRepository>(),
                  authPageRepository: context.read<AuthPageRepository>(),
                ),
                child: AddMembersPage(
                  gameGroupInfo: gameGroupInfo,
                ),
              ),
            );
        break;

      case AppRouterPaths.joinGameQrScan:
        builder = (_) => JoinGameQrScanPage();
        break;

      case AppRouterPaths.joinGameFindGameScan:
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
              child: BlocProvider(
                create: (context) => GameGroupChallangeFinderBloc(
                  gamePageRepository: context.read<GamePageRepository>(),
                  authPageRepository: context.read<AuthPageRepository>(),
                ),
                child: JoinGameGameFindPage(
                  groupQuizId: args.data['group_quiz_id'],
                ),
              ),
            );
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
