import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_sign_up/sign_up_page_bloc.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_text_input.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/validator_util.dart';
import 'package:sizer/sizer.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({Key? key}) : super(key: key);

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  ///TEXT CONTROLLERS
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpPageBloc, SignUpPageState>(
      listener: (context, state) {
        if (state is SignUpLoadedState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Account created',
            type: AnimatedSnackBarType.success,
          ).show(context);

          ///POP BACK TO LOGIN PAGE
          Navigator.pop(context);
        }

        if (state is SignUpLoadingErrorState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Network error, ty again',
            type: AnimatedSnackBarType.error,
          ).show(context);
        }

        if (state is SignUpAccountExistsState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.rectangle(
            "Account exists",
            "Account exists try loging in or resting password",
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
            builder: (context, state) {

              if (state is SignUpLoadingState) {
                return const Center(
                  child: AppLoadingWidget(),
                );
              }

              // if (state is SignUpLoadingErrorState) {
              //   return AppErrorWidget(
              //     onTryAgain: () {
              //       context.read<SignUpPageBloc>().add(
              //         SignUpEvent(
              //           name:
              //           '${firstNameTextEditingController.text} ${lastNameTextEditingController.text}',
              //           phoneNumber:
              //           phoneNumberTextEditingController.text,
              //           password: passwordTextEditingController.text,
              //           email: emailTextEditingController.text,
              //         ),
              //       );
              //     },
              //   );
              // }

              return buildMainView();
            },
          ),
        ),
      ),
    );
  }

  buildMainView() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.mp_v_8,
            ),

            ///BUILD APP LOGO
            buildAppLogo(),

            SizedBox(
              height: AppSizes.mp_v_8,
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
    return Form(
      key: _form,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
        child: AppCard(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_6,
              vertical: AppSizes.mp_v_2,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.gold,
                        fontSize: AppSizes.font_14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                AppTextInput(
                  textEditingController: firstNameTextEditingController,
                  validator:
                      ValidationBuilder().minLength(2).maxLength(25).build(),
                  hint: "First Name",
                  prefixIcon: FontAwesomeIcons.solidUser,
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                AppTextInput(
                  textEditingController: lastNameTextEditingController,
                  validator:
                      ValidationBuilder().minLength(2).maxLength(25).build(),
                  hint: "Last Name",
                  prefixIcon: FontAwesomeIcons.solidUser,
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                AppTextInput(
                  textEditingController: phoneNumberTextEditingController,
                  validator: (String? value) {
                    if (value == null) {
                      return "Please Provide valid Phone Number!";
                    }

                    if (!ValidatorUtil.isPhoneValidEthiopian(value)) {
                      return "Please Provide valid Phone Number!";
                    }

                    return null;
                  },
                  hint: "Phone Number",
                  prefixIcon: FontAwesomeIcons.solidPhone,
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                AppTextInput(
                  textEditingController: emailTextEditingController,
                  validator: ValidationBuilder().email().build(),
                  hint: "Email",
                  prefixIcon: FontAwesomeIcons.solidMessage,
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
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
                Container(
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

                          context.read<SignUpPageBloc>().add(
                                SignUpEvent(
                                  name:
                                      '${firstNameTextEditingController.text} ${lastNameTextEditingController.text}',
                                  phoneNumber:ValidatorUtil.formatPhoneNumber(phoneNumberTextEditingController.text)
                                  ,
                                  password: passwordTextEditingController.text,
                                  email: emailTextEditingController.text,
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
                      'Sign Up',
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
                  height: AppSizes.mp_v_2,
                ),
                SizedBox(
                  width: AppSizes.mp_w_16 * 3,
                  child: Divider(
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already Have An Account ?",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.grey,
                                    fontSize: AppSizes.font_12,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        AppButtonFeedBack(
                          child: Padding(
                            padding: EdgeInsets.all(AppSizes.mp_w_2),
                            child: Text(
                              "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.gold,
                                    fontSize: AppSizes.font_12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
