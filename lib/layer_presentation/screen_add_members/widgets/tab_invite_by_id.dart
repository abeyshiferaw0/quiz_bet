import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_presentation/screen_add_members/widgets/item_invited_person.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class TabInviteById extends StatelessWidget {
  TabInviteById({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
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
                  vertical: AppSizes.mp_v_2,
                ),
                hintText: "Search By Id",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w600,
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.radius_6,
                  ),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Container(
                  width: AppSizes.icon_size_28,
                  padding: EdgeInsets.only(right: AppSizes.mp_w_2),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.black,
                        backgroundColor: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.darkBlue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              AppSizes.radius_6,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.plus,
                            size: AppSizes.icon_size_4,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: AppSizes.mp_w_2,
                          ),
                          Text(
                            'Add',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.white,
                                      fontSize: AppSizes.font_12,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSizes.mp_v_4,
          ),
          Text(
            '6 - Invited Persons',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.gold,
                  fontSize: AppSizes.font_12,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: AppSizes.mp_v_10),
              itemBuilder: (context,index){
                return ItemInvitedPerson();
              },
              separatorBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_1 / 2,
                  ),
                  child: Divider(
                    color: AppColors.lightGrey,
                  ),
                );
              },
              itemCount: 12,
            ),
          ),
        ],
      ),
    );
  }
}
