import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class ItemOnboardCircle extends StatefulWidget {
  ItemOnboardCircle(
      {Key? key,
      required this.size,
      required this.color,
      required this.image,
      required this.isAnimated, required this.title})
      : super(key: key);

  final double size;
  final Color color;
  final String image;
  final bool isAnimated;
  final String title;

  @override
  State<ItemOnboardCircle> createState() => _ItemOnboardCircleState();
}

class _ItemOnboardCircleState extends State<ItemOnboardCircle> {
  Color bgDimColor = AppColors.completelyBlack.withOpacity(0.0);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        CircleAvatar(
          radius: widget.size,
          backgroundColor: AppColors.transparent,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gold,
                      AppColors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // stops: [0.0, 0.2],
                  ),
                  borderRadius: BorderRadius.circular(widget.size),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.mp_v_1 * 0.4,
                  // left: AppSizes.mp_w_1,
                  // right: AppSizes.mp_w_1,
                ),
                child: CircleAvatar(
                  radius: widget.size,
                  //backgroundColor: color,
                  backgroundImage: AssetImage(widget.image),
                  child: Stack(
                    children: [
                      widget.isAnimated
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(widget.size),
                                color: bgDimColor,
                              ),
                            )
                          : const SizedBox(),
                      widget.isAnimated
                          ? buildAnimatedText(context)
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildAnimatedText(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(FontAwesomeIcons.albumCirclePlus),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontSize: AppSizes.font_14,
                    fontWeight: FontWeight.bold,
                  ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: Duration(seconds: Random().nextInt(2)),
                animatedTexts: [
                  RotateAnimatedText(
                   widget.title,
                  ),
                ],
                onNext: (i, b) {
                  //  print("onNext Event");
                  setState(() {
                    bgDimColor = AppColors.completelyBlack.withOpacity(0.4);
                  });
                },
                onNextBeforePause: (i, b) {
                  // print("onNextBeforePause Event");
                  setState(() {
                    bgDimColor = AppColors.completelyBlack.withOpacity(0.2);
                  });
                },
                onTap: () {
                  //print("Tap Event");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
