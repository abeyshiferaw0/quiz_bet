import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AuthPinInputPagePage extends StatefulWidget {
  const AuthPinInputPagePage({Key? key}) : super(key: key);

  @override
  State<AuthPinInputPagePage> createState() => _AuthPinInputPagePageState();
}

class _AuthPinInputPagePageState extends State<AuthPinInputPagePage> {
  ///CONTROLLERS
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.mp_v_2,
            ),

            Expanded(
              child: SizedBox(),
            ),

            ///BUILD APP LOGO
            buildAppLogo(),

            Expanded(
              child: SizedBox(),
            ),

            ///BUILD QUESTION ANIMATION
            buildLockAnimation(),

            Expanded(
              child: SizedBox(),
            ),

            ///BUILD INPUT FORM
            buildInputForm(),
          ],
        ),
      ),
    );
  }

  buildAppLogo() {
    return Row(
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
    );
  }

  buildInputForm() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_6,
            vertical: AppSizes.mp_v_4,
          ),
          child: Column(
            children: [
              Text(
                "OTP verification",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gold,
                      fontSize: AppSizes.font_14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Text(
                "Please enter your phone number and get confirmation code",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.darkGrey,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_4,
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.darkGrey,
                            fontSize: AppSizes.font_12,
                            fontWeight: FontWeight.w400,
                          ),
                  length: 4,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: AppSizes.icon_size_16,
                    activeColor: AppColors.gold,
                    inactiveColor: AppColors.darkGold,
                    activeFillColor: AppColors.white,
                    inactiveFillColor: AppColors.white,
                    selectedColor: AppColors.gold,
                    selectedFillColor: AppColors.white,
                    // fieldOuterPadding:
                    //     EdgeInsets.symmetric(horizontal: AppSizes.mp_w_1),
                  ),

                  cursorColor: AppColors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,

                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_4,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.gold,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.mp_v_2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          AppSizes.radius_6,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterPaths.authInputPin);
                  },
                  child: Text(
                    'Verify',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildLockAnimation() {
    return Lottie.asset(
      AppAssets.lockLottie,
      width: AppSizes.icon_size_32 * 1.1,
      height: AppSizes.icon_size_32 * 1.1,
    );
  }
}
