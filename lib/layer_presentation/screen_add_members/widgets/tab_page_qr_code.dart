import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class TabInviteQr extends StatelessWidget {
  const TabInviteQr({Key? key, required this.gameGroupInfo}) : super(key: key);

  final GameGroupInfo gameGroupInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [



            SizedBox(
              height: AppSizes.mp_v_8,
            ),
            PrettyQr(
              image: AssetImage(AppAssets.appLogo),
              typeNumber: 3,
              size: AppSizes.icon_size_28 * 1.6,
              data: gameGroupInfo.groupQuizId,
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: true,
              elementColor: AppColors.gold,
            ),
            SizedBox(
              height: AppSizes.mp_v_4,
            ),
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
            SizedBox(
              height: AppSizes.mp_v_16,
            ),
          ],
        ),
      ),
    );
  }
}
