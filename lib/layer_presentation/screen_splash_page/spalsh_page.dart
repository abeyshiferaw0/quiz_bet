import 'package:flutter/material.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/pages_util.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {

    bool isUserLoggedIn = AuthPageService().isUserLoggedIn();


    if(isUserLoggedIn){
      Future.delayed(const Duration(milliseconds: 2000),(){
        Navigator.popAndPushNamed(context, AppRouterPaths.mainScreen);
      });
    }else{
      Future.delayed(const Duration(milliseconds: 2000),(){
       Navigator.popAndPushNamed(context, AppRouterPaths.onBoardingPage);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   width: double.infinity,
          //   color: Colors.black.withOpacity(0.05),
          // ),

          Opacity(
            opacity: 0.05,
            child: Image.asset(
              AppAssets.tileBackgroundTwo,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  width: AppSizes.icon_size_16,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: AppSizes.mp_w_6,
                ),
                Text(
                  "QUIZ BET".toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_14 * 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
