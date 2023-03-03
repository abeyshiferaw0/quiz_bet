import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemGroupGameYouWon extends StatefulWidget {
  const ItemGroupGameYouWon({
    Key? key, required this.winningPrize, required this.numberOfPlayers, required this.placedBet, required this.vatPer, required this.vatDeducted,
  }) : super(key: key);

  final String winningPrize;
  final String numberOfPlayers;
  final String placedBet;
  final String vatPer;
  final String vatDeducted;

  @override
  State<ItemGroupGameYouWon> createState() => _ItemGroupGameYouWonState();
}

class _ItemGroupGameYouWonState extends State<ItemGroupGameYouWon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.mp_v_2),
      child: Material(
        elevation: 2,
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
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

                  SizedBox(
                    height: AppSizes.mp_v_1,
                  ),

                  ///CONGRATULATIONS HEADER
                  buildCongratulationsHeader(context),

                  SizedBox(
                    height: AppSizes.mp_v_1,
                  ),

                  ///BUILD QUESTION
                  buildPrizeInfoInfo(context),

                  SizedBox(
                    height: AppSizes.mp_v_6,
                  ),

                  ///PRIZE DETAIL INFO
                  buildPrizeDetailContainer(context),

                  SizedBox(
                    height: AppSizes.mp_v_6,
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
                "Prize Details",
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
                "Winning Prize",
                "${widget.winningPrize} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "Number of players",
                "${widget.numberOfPlayers} Players",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "VAT ${widget.vatPer}%",
                "${widget.vatDeducted} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
              buildInfoItem(
                context,
                "Placed Bet",
                "${widget.placedBet} ETB",
                AppColors.darkBlue,
              ),
              SizedBox(height: AppSizes.mp_v_1),
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
                fontSize: AppSizes.font_10,
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
                    "${widget.winningPrize} ETB",
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
              onPressed: () {
Navigator.pop(context);
              },
              child:  Column(
                children: [
                  Text(
                    'Play',
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
                    "Another Game",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.white,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: AppSizes.mp_v_4,
          ),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
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
