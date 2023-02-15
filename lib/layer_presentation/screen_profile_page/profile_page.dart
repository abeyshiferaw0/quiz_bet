import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_profile_page/profile_page_bloc.dart';
import 'package:quiz_bet/layer_data/models/profile_page_data.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/screen_profile_page/widgets/item_quiz_history.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfilePageBloc>().add(LoadProfilePageEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
        if (state is ProfilePageLoading) {
          return const AppLoadingWidget();
        }

        if (state is ProfilePageLoadingFailed) {
          return AppErrorWidget(
            onTryAgain: () {
              context.read<ProfilePageBloc>().add(LoadProfilePageEvent());
            },
          );
        }

        if (state is ProfilePageLoaded) {
          return buildLoadedView(context,state.profilePageData);
        }

        return SizedBox();
      }),
    );
  }

  SingleChildScrollView buildLoadedView(BuildContext context, ProfilePageData profilePageData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///BUILD PROFILE HEADER
          buildProfileHeader(profilePageData),

          SizedBox(
            height: AppSizes.mp_v_1,
          ),

          ///BUILD WALLET CONTAINER
          buildWalletContainer(context,profilePageData),

          SizedBox(
            height: AppSizes.mp_v_1,
          ),

          ///BUILD QUIZ HISTORY
          buildQuizHistory(),
        ],
      ),
    );
  }

  Container buildWalletContainer(BuildContext context, ProfilePageData profilePageData) {
    return Container(
      width: double.infinity,
      height: 22.h,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_3,
        vertical: AppSizes.mp_v_2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius_12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: AppColors.completelyBlack.withOpacity(0.12),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        children: [
          GlassImage(
            blur: 12,
            height: 22.h,
            width: double.infinity,
            image: Image.network(
              "https://media.istockphoto.com/id/1130968781/vector/elegant-light-and-shine-vector-gold-blurred-gradient-style-background-texture-abstract-metal.jpg?s=612x612&w=0&k=20&c=S0h1mnW4K05RhgsIXxROyt_6T8kIVqMabUYYUTWj2wY=",
              fit: BoxFit.cover,
            ),
            overlayColor: AppColors.white.withOpacity(0.5),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.white.withOpacity(0.2),
                AppColors.white.withOpacity(0.1),
              ],
            ),
            shadowStrength: 0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_6,
              vertical: AppSizes.mp_v_2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.darkBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          "${profilePageData.balance.toStringAsFixed(2)} ETB".toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.darkGold,
                                    fontSize: AppSizes.font_18,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    BouncingButton(
                      child: Icon(
                        FontAwesomeIcons.solidEye,
                        size: AppSizes.icon_size_4,
                        color: AppColors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Material(
                      color: AppColors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.mp_w_4,
                          vertical: AppSizes.mp_v_2 * 0.9,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.wallet,
                              color: AppColors.gold,
                              size: AppSizes.icon_size_6 * 0.8,
                            ),
                            SizedBox(
                              width: AppSizes.mp_w_4,
                            ),
                            Text(
                              "Insert Money",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.darkBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_4,
                    ),
                    Material(
                      color: AppColors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radius_6),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.mp_w_4,
                          vertical: AppSizes.mp_v_2 * 0.9,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.arrowRightArrowLeft,
                              color: AppColors.gold,
                              size: AppSizes.icon_size_6 * 0.8,
                            ),
                            SizedBox(
                              width: AppSizes.mp_w_4,
                            ),
                            Text(
                              "Withdraw",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.darkBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildProfileHeader(ProfilePageData profilePageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 35.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                      AppSizes.radius_12 * 2,
                    ),
                  ),
                  child: Image.asset(
                    AppAssets.tileBackground,
                    width: double.infinity,
                    height: 28.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 14.h,
                  height: 14.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSizes.radius_12,
                    ),
                    border: Border.all(
                      color: AppColors.green,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSizes.radius_10,
                    ),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80",
                      width: 14.h,
                      height: 14.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 14.h, top: 14.h),
                  child: SizedBox(
                    width: AppSizes.icon_size_10,
                    height: AppSizes.icon_size_10,
                    child: Material(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      elevation: 2,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.solidPen,
                          color: AppColors.gold,
                          size: AppSizes.icon_size_4 * 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_6,
                      vertical: AppSizes.mp_v_4,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: AppSizes.mp_w_6,
                        ),
                        BouncingButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppColors.white,
                            size: AppSizes.icon_size_6,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppAssets.appLogo,
                                width: AppSizes.icon_size_8,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: AppSizes.mp_w_2,
                              ),
                              Text(
                                "QUIZ BET".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.white,
                                      fontSize: AppSizes.font_14,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSizes.mp_v_2,
        ),
        Text(
          "${profilePageData.user.phoneNumber}",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: AppSizes.mp_v_1 / 2,
        ),
        Text(
          "ID: ${profilePageData.user.id}",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkBlue,
                fontSize: AppSizes.font_9,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  buildQuizHistory() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
        vertical: AppSizes.mp_v_1,
      ),
      child: Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.completelyBlack.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        child: AppCard(
          child: Padding(
            padding: EdgeInsets.all(
              AppSizes.mp_w_4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quiz History",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.darkGrey,
                        fontSize: AppSizes.font_12,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: AppSizes.mp_v_2,
                  ),
                  itemBuilder: (context, index) {
                    return ItemQuizHistory();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: AppSizes.mp_v_1,
                    );
                  },
                  itemCount: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
