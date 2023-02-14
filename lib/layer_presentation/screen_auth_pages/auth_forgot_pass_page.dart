import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_auth_pages/bloc_forgot_password/forgot_password_page_bloc.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_text_input.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/validator_util.dart';

class AuthForgotPassPage extends StatefulWidget {
  const AuthForgotPassPage({Key? key}) : super(key: key);

  @override
  State<AuthForgotPassPage> createState() => _AuthForgotPassPageState();
}

class _AuthForgotPassPageState extends State<AuthForgotPassPage> {
  ///TEXT CONTROLLERS
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordPageBloc, ForgotPasswordPageState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoadingErrorState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Network error, ty again',
            type: AnimatedSnackBarType.error,
          ).show(context);
        }

        if (state is ForgotPasswordLoadedState) {
          ///SIGN UP SUCCESSFULLY
          AnimatedSnackBar.material(
            'Otp Sent',
            type: AnimatedSnackBarType.success,
          ).show(context);

          Navigator.pushNamed(
            context,
            AppRouterPaths.authInputPin,
            arguments: ScreenArguments(
              data: {
                'phone_number': ValidatorUtil.formatPhoneNumber(phoneTextEditingController.text),
              },
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ForgotPasswordPageBloc, ForgotPasswordPageState>(
            builder: (context, state) {
              if (state is ForgotPasswordLoadingState) {
                return AppLoadingWidget();
              }

              return buildMainView();
            },
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
            height: AppSizes.mp_v_8,
          ),

          ///BUILD APP LOGO
          buildAppLogo(),

          SizedBox(
            height: AppSizes.mp_v_6,
          ),

          ///BUILD QUESTION ANIMATION
          buildQuestionAnimation(),

          SizedBox(
            height: AppSizes.mp_v_6,
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
                  "Forgot Password",
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
                  height: AppSizes.mp_v_6,
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
                  height: AppSizes.mp_v_6,
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
                        context.read<ForgotPasswordPageBloc>().add(
                              ForgotPasswordEvent(
                                phoneNumber: ValidatorUtil.formatPhoneNumber(
                                    phoneTextEditingController.text),
                              ),
                            );
                      }
                    },
                    child: Text(
                      'Send Conformation Code',
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

  buildQuestionAnimation() {
    return Lottie.asset(
      AppAssets.questionLottie,
      width: AppSizes.icon_size_32 * 1.1,
      height: AppSizes.icon_size_32 * 1.1,
    );
  }
}
