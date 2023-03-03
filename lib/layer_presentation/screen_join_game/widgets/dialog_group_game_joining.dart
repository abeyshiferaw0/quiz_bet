import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_joining/game_group_joining_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/theme/app_assets.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class DialogGroupGameJoining extends StatefulWidget {
  const DialogGroupGameJoining({
    Key? key,
    required this.groupQuizId,
    required this.categoryId,
    required this.onGameJoined,
  }) : super(key: key);

  final String groupQuizId;
  final String categoryId;
  final Function(GameGroupInfo gameGroupInfo) onGameJoined;

  @override
  State<DialogGroupGameJoining> createState() => _DialogGroupGameJoiningState();
}

class _DialogGroupGameJoiningState extends State<DialogGroupGameJoining> {
  @override
  void initState() {
    super.initState();

    context.read<GameGroupJoiningBloc>().add(
          JoinGameGroupEvent(
            groupQuizId: widget.groupQuizId,
            categoryId: widget.categoryId,
          ),
        );
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
            child: BlocConsumer<GameGroupJoiningBloc, GameGroupJoiningState>(
              listener: (context, state) {
                if (state is GameGroupJoiningLoadedState) {
                  widget.onGameJoined(state.gameGroupInfo);
                }
              },
              builder: (context, state) {
                if (state is GameGroupJoiningLoadingState) {
                  return buildLoadingView(context);
                }

                if (state is GameGroupJoiningLoadingErrorState) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: AppSizes.mp_v_4),
                    child: AppErrorWidget(
                      onTryAgain: () {
                        context.read<GameGroupJoiningBloc>().add(
                              JoinGameGroupEvent(
                                groupQuizId: widget.groupQuizId,
                                categoryId: widget.categoryId,
                              ),
                            );
                      },
                    ),
                  );
                }

                return buildLoadingView(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Column buildLoadingView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        Icon(
          FontAwesomeIcons.solidCircleInfo,
          size: AppSizes.icon_size_6,
          color: AppColors.green,
        ),

        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        ///BUILD DIALOG TITLE
        Text(
          "Joining Game",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.green,
                fontSize: AppSizes.font_12,
                fontWeight: FontWeight.bold,
              ),
        ),

        SizedBox(
          height: AppSizes.mp_v_2,
        ),

        Material(
          color: AppColors.gold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSizes.radius_6),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.mp_v_1,
              horizontal: AppSizes.mp_w_4,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   FontAwesomeIcons.solidCircleInfo,
                //   size: AppSizes.icon_size_6,
                //   color: AppColors.gold,
                // ),
                // SizedBox(
                //   width: AppSizes.mp_v_2,
                // ),
                Expanded(
                  child: Text(
                    "Once you have started this quiz you can not quit no matter what happens.",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkGold,
                          fontSize: AppSizes.font_8,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        Lottie.asset(
          AppAssets.gameLoading,
          width: AppSizes.icon_size_32,
          height: AppSizes.icon_size_32,
        ),

        SizedBox(
          height: AppSizes.mp_v_1,
        ),

        Text(
          "Please make sure you have a stable intent connection!!!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkBlue,
                fontSize: AppSizes.font_9,
                fontWeight: FontWeight.w400,
              ),
        ),

        SizedBox(
          height: AppSizes.mp_v_1,
        ),
      ],
    );
  }
}
