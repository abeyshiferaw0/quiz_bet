import 'package:bouncing_button/bouncing_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_data/models/category_trending.dart';
import 'package:quiz_bet/layer_presentation/common/app_image_place_holder.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';


class ItemTrendingGame extends StatelessWidget {
  const ItemTrendingGame({
    Key? key, required this.onPlay, required this.categoryTrending,
  }) : super(key: key);

  final VoidCallback onPlay;
  final CategoryTrending categoryTrending;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.5.h,bottom: AppSizes.mp_v_4,),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.radius_8),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(0, 0),
                blurRadius: 4.0,
                spreadRadius: 4.0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius_8),
            child: Column(
              children: [
                //BUILD ITEM HEADER
                buildItemHeader(context),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                ///BUILD PRIZE AMOUNT
                buildPrizeAmount(context),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                ///BUILD START BUTTON
                buildStartButton(context),

                SizedBox(height: AppSizes.mp_v_4,),
              ],
            ),
          ),
        ),

        ///ITEM CATEGORY
        Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            children: [
              Container(
                height: 5.h,
                padding: EdgeInsets.symmetric(
                  //vertical: AppSizes.mp_v_1,
                  horizontal: AppSizes.mp_w_12,
                ),
                margin: EdgeInsets.symmetric(
                  //vertical: AppSizes.mp_v_1,
                  horizontal: AppSizes.mp_w_16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radius_12 * 100),
                  border: Border.all(
                    color: AppColors.gold,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    categoryTrending.name.nameAm,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildPrizeAmount(BuildContext context) {
    return Container(
      width: 54.w,
      padding: EdgeInsets.symmetric(vertical: AppSizes.mp_v_2),
      decoration: BoxDecoration(
        color: AppColors.lightWhite,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Play Win \nUp To",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_10,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Text(
              "${categoryTrending.totalOdds}X",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  buildItemHeader(context) {
    return SizedBox(
      height: 25.h,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: categoryTrending.image.mediumImage,
            height: 20.h,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context,url)=>const AppPlaceHolderImage(),
            errorWidget: (context, url, error) => const AppPlaceHolderImage(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.circular(AppSizes.radius_6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${categoryTrending.questionsCount}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Questions",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontSize: AppSizes.font_9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: AppSizes.mp_w_4,
                ),
                Container(
                  height: 10.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.circular(AppSizes.radius_6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${categoryTrending.levelsCount}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Levels",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontSize: AppSizes.font_9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildStartButton(context) {
    return BouncingButton(
      onPressed: onPlay,
      child: Container(
        width: 54.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius_6),
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.mp_v_2 * 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.solidPlay,
                size: AppSizes.icon_size_4,
                color: AppColors.black,
              ),
              SizedBox(
                width: AppSizes.mp_w_4,
              ),
              Text(
                "Start",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
