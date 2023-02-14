import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_password_reset/password_reset_page_bloc.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_text_input.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AuthPasswordResetPage extends StatefulWidget {
  const AuthPasswordResetPage({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;

  @override
  State<AuthPasswordResetPage> createState() => _AuthPasswordResetPageState();
}

class _AuthPasswordResetPageState extends State<AuthPasswordResetPage> {
  ///CONTROLLERS
  final _form = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

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
    return BlocListener<PasswordResetPageBloc, PasswordResetPageState>(
      listener: (context, state) {
        if (state is PasswordResetLoadedState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Password changed',
            type: AnimatedSnackBarType.success,
          ).show(context);

          Navigator.popUntil(
              context, ModalRoute.withName(AppRouterPaths.authSignIn));
        }
        if (state is PasswordResetLoadingErrorState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Network error, ty again',
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: BlocBuilder<PasswordResetPageBloc, PasswordResetPageState>(
              builder: (context, state) {

                if(state is PasswordResetLoadingState){
                  return AppLoadingWidget();
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSizes.mp_v_2,
                      ),

                      SizedBox(
                        height: AppSizes.mp_v_6,
                      ),

                      ///BUILD APP LOGO
                      buildAppLogo(),

                      SizedBox(
                        height: AppSizes.mp_v_6,
                      ),

                      ///BUILD QUESTION ANIMATION
                      buildLockAnimation(),

                      SizedBox(
                        height: AppSizes.mp_v_6,
                      ),

                      ///BUILD INPUT FORM
                      buildInputForm(),
                    ],
                  ),
                );

              },
            ),
          ),
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
    return Form(
      key: _form,
      child: Container(
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
                  "New Password",
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
                AppTextInput(
                  textEditingController: passwordTextEditingController,
                  validator:
                      ValidationBuilder().minLength(6).maxLength(25).build(),
                  hint: "Password",
                  prefixIcon: FontAwesomeIcons.solidLockKeyhole,
                  isPassword: true,
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                AppTextInput(
                  textEditingController: confirmPasswordTextEditingController,
                  validator:
                      ValidationBuilder().minLength(6).maxLength(25).build(),
                  hint: "Confirm Password",
                  prefixIcon: FontAwesomeIcons.solidLockKeyhole,
                  isPassword: true,
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
                      if (_form.currentState!.validate()) {
                        if (passwordTextEditingController.text ==
                            confirmPasswordTextEditingController.text) {
                          context.read<PasswordResetPageBloc>().add(
                                ResetPasswordEvent(
                                  phoneNumber: widget.phoneNumber,
                                  newPassword:
                                      passwordTextEditingController.text,
                                ),
                              );
                        } else {
                          AnimatedSnackBar.material(
                            'Password do not match',
                            type: AnimatedSnackBarType.info,
                          ).show(context);
                        }
                      } else {
                        AnimatedSnackBar.material(
                          'Form not completed',
                          type: AnimatedSnackBarType.info,
                        ).show(context);
                      }
                    },
                    child: Text(
                      'Reset',
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
      ),
    );
  }

  buildLockAnimation() {
    return Lottie.asset(
      AppAssets.createNewPasswordLottie,
      width: AppSizes.icon_size_32 * 1.3,
      height: AppSizes.icon_size_32 * 1.3,
    );
  }
}
