import 'package:flutter/material.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AppCard extends StatelessWidget {
  const AppCard(
      {Key? key,
      required this.child,
       this.color,
       this.radius})
      : super(key: key);

  final Widget child;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? AppSizes.radius_6),
        color: color ?? AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGrey.withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
