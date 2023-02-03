import 'package:bouncing_button/bouncing_button.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:font_awesome_flutter/name_icon_mapping.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_1,
        vertical: AppSizes.mp_w_1 * 0.9,
      ),
      child: AppCard(
        child: AppButtonFeedBack(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouterPaths.gamePlayerInfoPage,
              arguments: ScreenArguments(
                data: {
                  'categoryId': category.id,
                },
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                faIconNameMapping[category.icon.name],
                size: AppSizes.icon_size_12,
                color: AppColors.darkBlue,
              ),
              SizedBox(
                height: AppSizes.mp_v_4,
              ),
              Text(
                category.name.nameAm,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
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
