import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class GameStartCountDownPage extends StatefulWidget {
  const GameStartCountDownPage(
      {Key? key,
      required this.gameInfo,
      required this.amountToBet,
      required this.vatPer})
      : super(key: key);

  final GameInfo gameInfo;
  final int amountToBet;
  final double vatPer;

  @override
  State<GameStartCountDownPage> createState() => _GameStartCountDownPageState();
}

class _GameStartCountDownPageState extends State<GameStartCountDownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ///BUILD APP BAR
            // buildAppBar(),

            SizedBox(
              height: AppSizes.mp_v_16,
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  width: AppSizes.icon_size_10,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: AppSizes.mp_w_6,
                ),
                Text(
                  "QUIZ BET".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            ///BUILD GAME COUNT DOWN
            Expanded(
              child: Center(
                child: buildGameCountDow(),
              ),
            ),

            Material(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radius_6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                child: Text(
                  "Please make sure you have a stable intent connection!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkGold,
                        fontSize: AppSizes.font_10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),

            SizedBox(
              height: AppSizes.mp_v_4,
            ),

            // ///BUILD CONTINUE BUTTON
            // buildContinueButton(context),

            SizedBox(
              height: AppSizes.mp_v_4,
            ),
          ],
        ),
      ),
    );
  }

  // Container buildContinueButton(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: AppSizes.mp_w_14,
  //     ),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: AppColors.white,
  //         backgroundColor: AppColors.darkBlue,
  //         padding: EdgeInsets.symmetric(
  //           vertical: AppSizes.mp_v_2,
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(
  //               AppSizes.radius_6,
  //             ),
  //           ),
  //         ),
  //       ),
  //       onPressed: () {
  //         Navigator.pushNamed(
  //           context,
  //           AppRouterPaths.gamePlayerPage,
  //         );
  //       },
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             'Continue',
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //                   color: AppColors.white,
  //                   fontSize: AppSizes.font_12,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //           ),
  //           SizedBox(
  //             width: AppSizes.mp_w_2,
  //           ),
  //           Icon(
  //             FontAwesomeIcons.solidCircleChevronRight,
  //             size: AppSizes.icon_size_4,
  //             color: AppColors.gold,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        //horizontal: AppSizes.mp_w_4,
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
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Level 1",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font_12,
                      ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 2,
                ),
                SizedBox(
                  height: AppSizes.icon_size_2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius_12),
                    ),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.green,
                      ),
                      backgroundColor: AppColors.lightGrey,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 3,
                ),
                Text(
                  "Questions 10/10",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontSize: AppSizes.font_9,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          SizedBox(
            width: AppSizes.mp_w_1,
          ),
        ],
      ),
    );
  }

  buildGameCountDow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(
          height: AppSizes.mp_v_6,
        ),
        Text(
          "Game will start in",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkGold,
                fontSize: AppSizes.font_14,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_2,
        ),
        SizedBox(
          height: AppSizes.icon_size_32,
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppColors.gold,
                  fontSize: AppSizes.font_28 * 2,
                  fontWeight: FontWeight.bold,
                ),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 500),
              //repeatForever: true,
              totalRepeatCount: 1,

              onNext: (i, b) {
                FlutterBeep.beep();
              },
              onFinished: () {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  AppRouterPaths.gamePlayerPage,
                  arguments: ScreenArguments(
                    data: {
                      "gameInfo": widget.gameInfo,
                      "amountToBet": widget.amountToBet,
                      "vatPer": widget.vatPer,
                    },
                  ),
                );
              },
              animatedTexts: [
                FadeAnimatedText(
                  '5',
                  duration: const Duration(milliseconds: 700),
                  textAlign: TextAlign.center,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: AppSizes.font_28 * 2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                FadeAnimatedText(
                  '4',
                  duration: const Duration(milliseconds: 700),
                  textAlign: TextAlign.center,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: AppSizes.font_28 * 2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                FadeAnimatedText(
                  '3',
                  duration: const Duration(milliseconds: 700),
                  textAlign: TextAlign.center,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: AppSizes.font_28 * 2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                FadeAnimatedText(
                  '2',
                  duration: const Duration(milliseconds: 700),
                  textAlign: TextAlign.center,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: AppSizes.font_28 * 2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                FadeAnimatedText(
                  '1',
                  duration: const Duration(milliseconds: 700),
                  textAlign: TextAlign.center,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: AppSizes.font_28 * 2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                FadeAnimatedText(
                  'Start',
                  fadeOutBegin: 0.9,
                  fadeInEnd: 0.8,
                  duration: const Duration(milliseconds: 700),
                  textAlign: TextAlign.center,
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: AppColors.green,
                            fontSize: AppSizes.font_28 * 2,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
