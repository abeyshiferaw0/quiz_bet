import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_presentation/screen_on_boarding/onboarding_page_one.dart';
import 'package:quiz_bet/layer_presentation/screen_on_boarding/onboarding_page_three.dart';
import 'package:quiz_bet/layer_presentation/screen_on_boarding/onboarding_page_two.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  ///
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: buildSlidePages(),
    );
  }

  PageView buildSlidePages() {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        OnBoardingPageOne(
          onNextTap: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        OnBoardingPageTwo(
          onNextTap: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          onPrvTap: () {
            pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        OnBoardingPageThree(
          onPrvTap: () {
            Navigator.popAndPushNamed(
              context,
              AppRouterPaths.authSignIn,
            );
          },
        ),
      ],
    );
  }
}
