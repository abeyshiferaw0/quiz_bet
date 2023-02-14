import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_sign_in/sign_in_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_sign_up/sign_up_page_bloc.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_text_input.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/validator_util.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({Key? key}) : super(key: key);

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  ///TEXT CONTROLLERS
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInPageBloc, SignInPageState>(
      listener: (context, state) {
        if (state is SignInPageLoadedState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Logged In',
            type: AnimatedSnackBarType.success,
          ).show(context);

          ///POP BACK TO LOGIN PAGE
          Navigator.popAndPushNamed(context, AppRouterPaths.mainScreen);
        }

        if (state is SignInPageLoadingErrorState) {
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
            child: BlocBuilder<SignInPageBloc, SignInPageState>(
              builder: (context, state) {
                if (state is SignInPageLoadedState) {
                  return AppLoadingWidget();
                }

                return buildMainView();
              },
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildMainView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppSizes.mp_v_10,
          ),

          ///BUILD APP LOGO
          buildAppLogo(),

          SizedBox(
            height: AppSizes.mp_v_10,
          ),

          ///BUILD INPUT FORM
          buildInputForm(),
        ],
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
                  "Sign In",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.gold,
                        fontSize: AppSizes.font_14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_4,
                ),
                AppTextInput(
                  textEditingController: phoneTextEditingController,
                  validator: (String? value) {
                    if (value == null) {
                      return "Please Provide valid Phone Number!";
                    }

                    if (!ValidatorUtil.isPhoneValidEthiopian(value)) {
                      return "Please Provide valid Phone Number!";
                    }

                    return null;
                  },
                  hint: "Phone number",
                  prefixIcon: FontAwesomeIcons.solidPhone,
                  keyboardType: TextInputType.number,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButtonFeedBack(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouterPaths.authForgetPass,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSizes.mp_v_2),
                      child: Text(
                        "Forgot Password",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.darkBlue,
                              //  fontSize: AppSizes.font_10,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
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
                        context.read<SignInPageBloc>().add(
                              SignInEvent(
                                phoneNumber: ValidatorUtil.formatPhoneNumber(
                                    phoneTextEditingController.text),
                                password: passwordTextEditingController.text,
                              ),
                            );
                      }else{
                        AnimatedSnackBar.material(
                          'Form not completed',
                          type: AnimatedSnackBarType.info,
                        ).show(context);
                      }
                    },
                    child: Text(
                      'Log In',
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
                  height: AppSizes.mp_v_4,
                ),
                SizedBox(
                  width: AppSizes.mp_w_16 * 3,
                  child: Divider(
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account ?",
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
                              "Sign Up",
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
                            Navigator.pushNamed(
                              context,
                              AppRouterPaths.authSignUp,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
