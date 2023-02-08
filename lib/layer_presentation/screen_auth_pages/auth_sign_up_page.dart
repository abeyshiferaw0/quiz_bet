import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({Key? key}) : super(key: key);

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  ///TEXT CONTROLLERS
  final TextEditingController phoneTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(),
            ),

            ///BUILD APP LOGO
            buildAppLogo(),

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
              Material(
                color: AppColors.lightWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  AppSizes.radius_6,
                ),
                child: TextFormField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) {},
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                      vertical: AppSizes.mp_v_2,
                    ),
                    hintText: "First Name",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidUser,
                      size: AppSizes.icon_size_4,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Material(
                color: AppColors.lightWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  AppSizes.radius_6,
                ),
                child: TextFormField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) {},
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                      vertical: AppSizes.mp_v_2,
                    ),
                    hintText: "Last Name",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidUser,
                      size: AppSizes.icon_size_4,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Material(
                color: AppColors.lightWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  AppSizes.radius_6,
                ),
                child: TextFormField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) {},
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                      vertical: AppSizes.mp_v_2,
                    ),
                    hintText: "Phone number",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidPhone,
                      size: AppSizes.icon_size_4,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Material(
                color: AppColors.lightWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  AppSizes.radius_6,
                ),
                child: TextFormField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) {},
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                      vertical: AppSizes.mp_v_2,
                    ),
                    hintText: "Password",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidLockKeyhole,
                      size: AppSizes.icon_size_4,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Material(
                color: AppColors.lightWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  AppSizes.radius_6,
                ),
                child: TextFormField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) {},
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                      vertical: AppSizes.mp_v_2,
                    ),
                    hintText: "confirm Password",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidLockKeyhole,
                      size: AppSizes.icon_size_4,
                      color: AppColors.gold,
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
                  onPressed: () {},
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
    );
  }
}
