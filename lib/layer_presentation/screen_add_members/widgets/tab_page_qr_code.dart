import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class TabPageFriends extends StatelessWidget {
  const TabPageFriends({Key? key,  required this.quizId}) : super(key: key);

  final String quizId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppSizes.mp_v_12,),
          PrettyQr(
            image: AssetImage(AppAssets.appLogo),
            typeNumber: 3,
            size: AppSizes.icon_size_28 * 1.6,
            data: quizId,
            errorCorrectLevel: QrErrorCorrectLevel.M,
            roundEdges: true,
            elementColor: AppColors.gold,
          ),
          SizedBox(height: AppSizes.mp_v_4,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_10),
            child: Text(
              "To invite your friends to join your group, Have them scan this qr code or send it to them.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
