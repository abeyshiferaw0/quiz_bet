import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_drop_down_input.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class CreateChallengePage extends StatefulWidget {
  const CreateChallengePage({Key? key}) : super(key: key);

  @override
  State<CreateChallengePage> createState() => _CreateChallengePageState();
}

class _CreateChallengePageState extends State<CreateChallengePage> {
  String? gender;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///BUILD APP BAR
            buildAppBar(),

            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_4,
              ),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(AppSizes.radius_6),
                color: AppColors.white,
                shadowColor: AppColors.completelyBlack.withOpacity(0.5),
                child: AppCard(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4,vertical: AppSizes.mp_v_2,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Start a Challenge",
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_2,
                        ),
                        AppDropdownInput(
                          list: ["Male", "Female"],
                          hint: "Select a Category",
                          onChanged: (String? value) {
                            setState(() {
                              gender = value;
                              // state.didChange(newValue);
                            });
                          },
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_1,
                        ),
                        AppDropdownInput(
                          list: ["Male", "Female"],
                          hint: "Select a level",
                          onChanged: (String? value) {
                            setState(() {
                              gender = value;
                              // state.didChange(newValue);
                            });
                          },
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppSizes.mp_w_4),
                          child: Text(
                            "Betting Money Entry",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: AppSizes.mp_w_2,
                            ),
                            Expanded(
                              child: Material(
                                color: AppColors.lightWhite.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius_6,
                                ),
                                child: TextFormField(
                                  controller: textEditingController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.mp_w_4,
                                      vertical: AppSizes.mp_v_2,
                                    ),
                                    hintText: "Eg. 150 ETB".toUpperCase(),
                                    hintStyle:
                                    Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.radius_6,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.dollarSign,
                                      size: AppSizes.icon_size_4,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.mp_w_8,
                            ),
                            Column(
                              children: [
                                Material(
                                  color: AppColors.darkBlue,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(AppSizes.radius_4),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.mp_w_6,
                                      vertical: AppSizes.mp_v_1 * 0.5,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.chevronUp,
                                        size: AppSizes.icon_size_4,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSizes.mp_v_1 / 3,
                                ),
                                Material(
                                  color: AppColors.darkBlue,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(AppSizes.radius_4),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.mp_w_6,
                                      vertical: AppSizes.mp_v_1 * 0.5,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.chevronDown,
                                        size: AppSizes.icon_size_4,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: AppSizes.mp_w_4,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: AppSizes.mp_v_4,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.white,
                              backgroundColor: AppColors.darkBlue,
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizes.mp_v_2 ,
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

                            },
                            child: Text(
                              'Continue',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: AppColors.white,
                                fontSize: AppSizes.font_12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

          BouncingButton(
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              size: AppSizes.icon_size_6,
              color: AppColors.gold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: SizedBox(),
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
                onPressed: () {},
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
}
