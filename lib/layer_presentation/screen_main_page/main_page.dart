import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_home_page/home_page_bloc.dart';
import 'package:quiz_bet/layer_data/repositories/repository_home_page.dart';
import 'package:quiz_bet/layer_data/services/service_home_page.dart';
import 'package:quiz_bet/layer_presentation/screen_frends_page/frends_page.dart';
import 'package:quiz_bet/layer_presentation/screen_home_page/home_page.dart';
import 'package:quiz_bet/layer_presentation/screen_main_page/widgets/side_menu.dart';
import 'package:quiz_bet/layer_presentation/screen_public_page/public_page.dart';
import 'package:quiz_bet/layer_presentation/screen_timer_page/timer_page.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _advancedDrawerController = AdvancedDrawerController();

  int _selectedBottomPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: AppColors.darkBlue,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.8,
      openRatio: 0.65,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      drawer: const SideMenu(),
      child: buildMainPageContents(),
    );
  }

  buildMainPageContents() {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              ///BUILD APP BAR
              buildAppBar(),

              Expanded(
                child: IndexedStack(
                  index: _selectedBottomPageIndex,
                  children: [

                    RepositoryProvider(
                      create: (context) =>
                          HomePageRepository(service: HomePageService()),
                      child: BlocProvider<HomePageBloc>(
                        create: (context) => HomePageBloc(
                          homePageRepository:
                              context.read<HomePageRepository>(),
                        ),
                        child: HomePage(),
                      ),
                    ),

                    FriendsPage(),
                    PublicPage(),
                    TimerPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Container buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSizes.radius_12),
          topLeft: Radius.circular(AppSizes.radius_12),
        ),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius_12),
          topRight: Radius.circular(AppSizes.radius_12),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              activeIcon: Icon(FontAwesomeIcons.solidHouse),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userPlus),
              activeIcon: Icon(FontAwesomeIcons.solidUserPlus),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userGroupCrown),
              activeIcon: Icon(FontAwesomeIcons.solidUserGroupCrown),
              label: 'Public',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.hourglassClock),
              activeIcon: Icon(FontAwesomeIcons.solidHourglassClock),
              label: 'Timer',
            ),
          ],
          currentIndex: _selectedBottomPageIndex,
          elevation: 2,
          unselectedItemColor: AppColors.darkGrey,
          selectedItemColor: AppColors.darkGold,
          iconSize: AppSizes.icon_size_4,
          backgroundColor: AppColors.white,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedBottomPageIndex = index;
    });
  }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        horizontal: AppSizes.mp_w_4,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
        vertical: AppSizes.mp_v_2,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _handleMenuButtonPressed,
            color: AppColors.gold,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.appLogo,
                width: AppSizes.icon_size_8 * 0.8,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: AppSizes.mp_w_1,
              ),
              Text(
                "QUIZ BET".toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "150 ETB",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gold,
                      fontSize: AppSizes.font_10,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_2,
              ),
              BouncingButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouterPaths.profilePage,
                  );
                },
                child: CircleAvatar(
                  radius: AppSizes.icon_size_6,
                  backgroundColor: AppColors.darkGold,
                  child: CircleAvatar(
                    radius: AppSizes.icon_size_6 * 0.93,
                    backgroundColor: AppColors.lightWhite,
                    backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
