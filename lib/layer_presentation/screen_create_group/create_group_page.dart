import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class CreateAGroupPage extends StatefulWidget {
  const CreateAGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateAGroupPage> createState() => _CreateAGroupPageState();
}

class _CreateAGroupPageState extends State<CreateAGroupPage> {

  final TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///BUILD APP BAR
            buildAppBar(),

            SizedBox(height: AppSizes.mp_v_4,),

            ///BUILD CREATE A GROUP FORM
            buildCreateForm(context),
          ],
        ),
      ),
    );
  }

  Padding buildCreateForm(BuildContext context) {
    return Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
            child: Column(
              children: [
                CircleAvatar(
                  radius: AppSizes.icon_size_24,
                  backgroundColor: AppColors.lightWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.rectangleHistoryCirclePlus,size: AppSizes.icon_size_12,color: AppColors.darkBlue,),
                      SizedBox(height: AppSizes.mp_v_2,),
                      Text(
                        "Profile Image",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: AppSizes.mp_v_4,),

                Material(
                  color: AppColors.lightWhite.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    AppSizes.radius_6,
                  ),
                  child: TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSizes.mp_w_4,
                        vertical: AppSizes.mp_v_4*0.6,
                      ),
                      hintText: "Group Name",
                      hintStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radius_6,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Padding(
                        padding:  EdgeInsets.only(right: AppSizes.mp_w_4),
                        child: Icon(
                          FontAwesomeIcons.dollarSign,
                          size: AppSizes.icon_size_6,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.mp_v_2,),

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
Navigator.pushNamed(context, AppRouterPaths.addMember,);
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
          );
  }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_2,
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
          Text(
            "Create a group",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
