import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class ItemGameResultCard extends StatelessWidget {
  const ItemGameResultCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return AppCard(
      radius: AppSizes.radius_12,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Lottie.asset(
              AppAssets.fireWorkLottie,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///BUILD TOP LINER PROGRESS
                buildTopProgress(context),

                ///CONGRATULATIONS HEADER
                buildCongratulationsHeader(context),

                ///BUILD QUESTION
                buildPrizeInfoInfo(context),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                ///PRIZE DETAIL INFO
                buildPrizeDetailContainer(context),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                ///BUILD ACTION BUTTONS
                buildActionButtons(context),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   buildCongratulationsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "CONGRATULATIONS".toUpperCase(),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.green,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          width: AppSizes.mp_w_2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: AppSizes.mp_v_4 * 0.8,
          ),
          child: Lottie.asset(
            AppAssets.trumpateLottie,
            width: AppSizes.icon_size_12,
            height: AppSizes.icon_size_12,
          ),
        ),
      ],
    );
  }

  buildTopProgress(context) {
    return SizedBox(
      height: AppSizes.icon_size_4 * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radius_12),
        ),
        child: LinearProgressIndicator(
          value: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.green,
          ),
          backgroundColor: AppColors.lightGrey,
        ),
      ),
    );
  }

  buildPrizeDetailContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_v_1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prize",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              buildInfoItem(
                context,
                "Deposit",
                "15.00 ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "VAT 15%",
                "1 ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "Placed Bet",
                "14.00 ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "Total Odd",
                "2.08",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "To Win",
                "28 ETB",
                AppColors.darkGold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildInfoItem(
      BuildContext context, String title, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.font_9,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.font_9,
              ),
        ),
      ],
    );
  }

  buildPrizeInfoInfo(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
      ),
      width: double.infinity,
      child: Material(
        color: AppColors.gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_2,
            horizontal: AppSizes.mp_w_6,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 5,
                child: Lottie.asset(
                  AppAssets.winnerBadgeLottie,
                  width: AppSizes.icon_size_4,
                  height: AppSizes.icon_size_4,
                ),
              ),
              SizedBox(
                width: AppSizes.mp_w_6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Winning Prize",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkBlue,
                          fontSize: AppSizes.font_10,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_1 / 2,
                  ),
                  Text(
                    "15 * 2.0808 = 31.212",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.gold,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.darkBlue,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Level Up And Win',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.gold,
                              fontSize: AppSizes.font_10,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Text(
                        '1050.00 ETB',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.white,
                              fontSize: AppSizes.font_12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AppSizes.mp_w_6,
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRightLong,
                    size: AppSizes.icon_size_6,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSizes.mp_v_2,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                foregroundColor: AppColors.grey,
                backgroundColor: AppColors.white,
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
              child:  Text(
                'Back To Home',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkGold,
                  fontSize: AppSizes.font_10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
