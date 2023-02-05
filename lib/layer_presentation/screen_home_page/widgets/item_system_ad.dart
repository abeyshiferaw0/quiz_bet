import 'package:bouncing_button/bouncing_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_data/models/ad.dart';
import 'package:quiz_bet/layer_presentation/common/app_image_place_holder.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class ItemSystemAd extends StatelessWidget {
  const ItemSystemAd({
    Key? key,
    required this.onTap,
    required this.ad, required this.height,
  }) : super(key: key);

  final Ad ad;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.only(

        right: AppSizes.mp_w_6,
      ),
      height:height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_8),

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius_8),
        child: CachedNetworkImage(
          imageUrl: ad.image.mediumImage,
          placeholder: (context,url)=>const AppPlaceHolderImage(),
          errorWidget: (context, url, error) => const AppPlaceHolderImage(),
        ),
      ),
    );
  }
}
