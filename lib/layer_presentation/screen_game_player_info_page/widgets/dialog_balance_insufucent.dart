import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class DialogBalanceInsuficent extends StatefulWidget {
  const DialogBalanceInsuficent({
    Key? key, required this.onWalletRecharge,
  }) : super(key: key);

  final VoidCallback onWalletRecharge;

  @override
  State<DialogBalanceInsuficent> createState() =>
      _DialogBalanceInsuficentState();
}

class _DialogBalanceInsuficentState extends State<DialogBalanceInsuficent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.radius_6),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_4,
                vertical: AppSizes.mp_v_2,
              ),
              width: 80.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppSizes.mp_v_1,
                  ),

                  Icon(
                    FontAwesomeIcons.circleDollar,
                    size: AppSizes.icon_size_6,
                    color: AppColors.red,
                  ),

                  SizedBox(
                    height: AppSizes.mp_v_2,
                  ),

                  ///BUILD DIALOG TITLE
                  Text(
                    "Balance insufficient to start game",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.red,
                          fontSize: AppSizes.font_12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: AppSizes.mp_v_2,
                  ),

                  Material(
                    color: AppColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radius_6),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.mp_v_2,
                        horizontal: AppSizes.mp_w_6,
                      ),
                      child: Text(
                        "Your balance is insufficient to start playing games!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.red,
                              fontSize: AppSizes.font_10,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: AppSizes.mp_v_4,
                  ),

                  Row(
                    children: [
                      ///BUILD CANCEL BUTTON
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.black,
                            backgroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.mp_v_2 * 0.8,
                            ),
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
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.darkBlue,
                                      fontSize: AppSizes.font_10,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppSizes.mp_w_2,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.white,
                            backgroundColor: AppColors.green,
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.mp_v_2 * 0.8,
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
                            widget.onWalletRecharge();



                          },
                          child: Text(
                            'Wallet Deposit',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.white,
                                      fontSize: AppSizes.font_10,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
