import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group_challange_create/game_group_challange_create_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group_create_challange/game_group_create_challange_bloc.dart';
import 'package:quiz_bet/layer_buisness/cubits/game_group_challange_create_cubits/game_group_create_challange_drop_down_cubit.dart';
import 'package:quiz_bet/layer_data/models/drop_down_common_model.dart';
import 'package:quiz_bet/layer_data/models/page_data_models/create_challange_page_data.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_drop_down_input.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_info_page/widgets/dialog_balance_insufucent.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/pages_util.dart';

class CreateChallengePage extends StatefulWidget {
  const CreateChallengePage({Key? key}) : super(key: key);

  @override
  State<CreateChallengePage> createState() => _CreateChallengePageState();
}

class _CreateChallengePageState extends State<CreateChallengePage> {
  DropDownCommonModel? selectedCategory;
  DropDownCommonModel? selectedLevel;
  final TextEditingController textEditingEntryAmountController =
      TextEditingController();
  final TextEditingController textEditingMaxNoPlayersController =
      TextEditingController();

  @override
  void initState() {
    context.read<GameGroupCreateChallangeBloc>().add(
          const FetchInitialInfo(),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///BUILD APP BAR
            buildAppBar(),

            BlocConsumer<GameGroupCreateChallangeBloc,
                GameGroupCreateChallangeState>(
              listener: (context, state) {
                if (state is GameGroupCreateChallangeLoadedState) {
                  ///IF USER BALANCE IS ZERO KICK OF GAME STARTING PAGE
                  if (state.createChallangePageData.walletBalance < 1) {
                    Navigator.pop(context);
                    showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return DialogBalanceInsuficent(
                          onWalletRecharge: () {
                            Navigator.pop(context);

                            Navigator.pushNamed(
                              context,
                              AppRouterPaths.profilePage,
                            );
                          },
                        );
                      },
                    );
                  }

                  ///CATEGORY SELECTED EVENT
                  ///FOR EVENT TO CHANGE
                  context
                      .read<GameGroupCreateChallangeDropDownCubit>()
                      .categorySelected(
                          state.createChallangePageData.categories.first);

                  ///SET SELECTED CATEGORY
                  selectedCategory = DropDownCommonModel(
                    id: state.createChallangePageData.categories.first.id,
                    name: state.createChallangePageData.categories.first.name,
                  );
                }
              },
              builder: (context, state) {
                if (state is GameGroupCreateChallangeLoadingState) {
                  return AppLoadingWidget();
                }
                if (state is GameGroupCreateChallangeLoadingErrorState) {
                  return AppErrorWidget(onTryAgain: () {
                    context.read<GameGroupCreateChallangeBloc>().add(
                          const FetchInitialInfo(),
                        );
                  });
                }
                if (state is GameGroupCreateChallangeLoadedState) {
                  return buildLoadedView(
                      context, state.createChallangePageData);
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  buildLoadedView(
      BuildContext context, CreateChallangePageData createChallangePageData) {
    return BlocConsumer<GameGroupChallangeCreateBloc,
        GameGroupChallangeCreateState>(
      listener: (context, state) {
        if (state is GameGroupChallangeCreateLoadedState) {
          Navigator.pushNamed(
            context,
            AppRouterPaths.addMember,
            arguments: ScreenArguments(
              data: {
                'quiz_id':state.groupQuizId,
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GameGroupChallangeCreateLoadingState) {
          return const AppLoadingWidget();
        }

        if (state is GameGroupChallangeCreateLoadingErrorState) {
          return AppErrorWidget(
            onTryAgain: () {
              context.read<GameGroupChallangeCreateBloc>().add(
                    GameGroupCreateChallangeeEvent(
                      amountPerPerson: textEditingEntryAmountController.text,
                      categoryId: selectedCategory!.id,
                      levelId: selectedLevel!.id,
                    ),
                  );
            },
          );
        }

        if (state is GameGroupChallangeCreateLoadedState) {
          return buildSecondLoadedView(context, createChallangePageData);
        }

        return buildSecondLoadedView(context, createChallangePageData);
      },
    );
  }

  Container buildSecondLoadedView(
      BuildContext context, CreateChallangePageData createChallangePageData) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        color: AppColors.white,
        shadowColor: AppColors.completelyBlack.withOpacity(0.5),
        child: AppCard(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_4,
              vertical: AppSizes.mp_v_2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Start a Challenge",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                AppDropdownInput(
                  list: createChallangePageData.categories
                      .map((e) => DropDownCommonModel(id: e.id, name: e.name))
                      .toList(),
                  initialValue: DropDownCommonModel(
                    id: createChallangePageData.categories.first.id,
                    name: createChallangePageData.categories.first.name,
                  ),
                  hint: "Select a Category",
                  onChanged: (DropDownCommonModel? value) {
                    if (value != null) {
                      context
                          .read<GameGroupCreateChallangeDropDownCubit>()
                          .categorySelected(
                            createChallangePageData.categories.firstWhere(
                                (element) => element.id == value.id),
                          );
                    }
                  },
                ),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
                BlocConsumer<GameGroupCreateChallangeDropDownCubit,
                    GameGroupCreateChallangeDropDownState>(
                  listener: (context, state) {
                    if (state
                        is GameGroupCreateChallangeDropDownOnCategorySelected) {
                      ///RESET SET SELECTED LEVEL
                      selectedLevel = null;
                    }
                  },
                  builder: (context, state) {
                    if (state
                        is GameGroupCreateChallangeDropDownOnCategorySelected) {
                      if (state.category.gameLevels!.isNotEmpty) {
                        ///SET SELECTED LEVEL
                        selectedLevel = DropDownCommonModel(
                          id: state.category.gameLevels!.first.id,
                          name: state.category.gameLevels!.first.name,
                        );

                        return AppDropdownInput(
                          list: state.category.gameLevels!
                              .map((e) =>
                                  DropDownCommonModel(id: e.id, name: e.name))
                              .toList(),
                          hint: "Select a level",
                          initialValue: DropDownCommonModel(
                            id: state.category.gameLevels!.first.id,
                            name: state.category.gameLevels!.first.name,
                          ),
                          onChanged: (DropDownCommonModel? value) {
                            ///SET SELECTED LEVEL VALUE
                            selectedLevel = value;
                          },
                        );
                      }
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: AppSizes.mp_w_4),
                  child: Text(
                    "Betting Money Entry",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppSizes.mp_w_2,
                    ),
                    Expanded(
                      child: Material(
                        color: AppColors.lightWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radius_6,
                        ),
                        child: TextFormField(
                          controller: textEditingEntryAmountController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSizes.mp_w_4,
                              vertical: AppSizes.mp_v_2,
                            ),
                            hintText: "Eg. 150 ETB".toUpperCase(),
                            hintStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.radius_6,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: Icon(
                              FontAwesomeIcons.dollarSign,
                              size: AppSizes.icon_size_4,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_8,
                    ),
                    Column(
                      children: [
                        Material(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.radius_4),
                          ),
                          child: AppButtonFeedBack(
                            onTap: () {
                              //FlutterBeep.beep();

                              ///IF MAX (BALANCE IS REACHED DON'T INCREMENT)
                              if (PagesUtil.getIncrementedBid(
                                          textEditingEntryAmountController.text)
                                      .toDouble() >
                                  createChallangePageData.walletBalance) {
                                ///CAN ADD MORE
                                AnimatedSnackBar.material(
                                  'Balance Limit Reached',
                                  type: AnimatedSnackBarType.warning,
                                ).show(context);
                              } else {
                                textEditingEntryAmountController.text =
                                    "${PagesUtil.getIncrementedBid(textEditingEntryAmountController.text)}";
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.mp_w_6,
                                vertical: AppSizes.mp_v_1 * 0.5,
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.chevronUp,
                                  size: AppSizes.icon_size_4,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_1 / 3,
                        ),
                        Material(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(AppSizes.radius_4),
                          ),
                          child: AppButtonFeedBack(
                            onTap: () {
                              //FlutterBeep.beep();
                              textEditingEntryAmountController.text =
                                  "${PagesUtil.getDescrimentedBid(textEditingEntryAmountController.text)}";
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.mp_w_6,
                                vertical: AppSizes.mp_v_1 * 0.5,
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.chevronDown,
                                  size: AppSizes.icon_size_4,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_4,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.mp_v_2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: AppSizes.mp_w_4),
                  child: Text(
                    "Maximum Number Of Players",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppSizes.mp_w_2,
                    ),
                    Expanded(
                      child: Material(
                        color: AppColors.lightWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radius_6,
                        ),
                        child: TextFormField(
                          controller: textEditingMaxNoPlayersController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSizes.mp_w_4,
                              vertical: AppSizes.mp_v_2,
                            ),
                            hintText: "Eg. 2 players".toUpperCase(),
                            hintStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.radius_6,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: Icon(
                              FontAwesomeIcons.user,
                              size: AppSizes.icon_size_4,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_8,
                    ),
                    Column(
                      children: [
                        Material(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.radius_4),
                          ),
                          child: AppButtonFeedBack(
                            onTap: () {
                              //FlutterBeep.beep();
                              textEditingMaxNoPlayersController.text =
                                  "${PagesUtil.getIncrementedBid(textEditingMaxNoPlayersController.text)}";
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.mp_w_6,
                                vertical: AppSizes.mp_v_1 * 0.5,
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.chevronUp,
                                  size: AppSizes.icon_size_4,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_1 / 3,
                        ),
                        Material(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(AppSizes.radius_4),
                          ),
                          child: AppButtonFeedBack(
                            onTap: () {
                              //FlutterBeep.beep();
                              textEditingMaxNoPlayersController.text =
                                  "${PagesUtil.getDescrimentedBid(textEditingMaxNoPlayersController.text)}";
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.mp_w_6,
                                vertical: AppSizes.mp_v_1 * 0.5,
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.chevronDown,
                                  size: AppSizes.icon_size_4,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppSizes.mp_w_4,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.mp_v_4,
                ),
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
                      bool canCreateGame = true;

                      if (selectedCategory == null) {
                        canCreateGame = false;
                        AnimatedSnackBar.material(
                          'Category not selected',
                          type: AnimatedSnackBarType.warning,
                        ).show(context);
                      }

                      if (selectedLevel == null) {
                        canCreateGame = false;
                        AnimatedSnackBar.material(
                          'Level not selected',
                          type: AnimatedSnackBarType.warning,
                        ).show(context);
                      }

                      if (textEditingEntryAmountController.text.isEmpty) {
                        canCreateGame = false;
                        AnimatedSnackBar.material(
                          'Betting amount not selected',
                          type: AnimatedSnackBarType.warning,
                        ).show(context);
                      }

                      if (textEditingMaxNoPlayersController.text.isEmpty) {
                        canCreateGame = false;
                        AnimatedSnackBar.material(
                          'Max number of players not selected',
                          type: AnimatedSnackBarType.warning,
                        ).show(context);
                      }

                      ///
                      if (canCreateGame) {
                        context.read<GameGroupChallangeCreateBloc>().add(
                              GameGroupCreateChallangeeEvent(
                                amountPerPerson:
                                    textEditingEntryAmountController.text,
                                categoryId: selectedCategory!.id,
                                levelId: selectedLevel!.id,
                              ),
                            );
                      }
                    },
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.white,
                            fontSize: AppSizes.font_12,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        horizontal: AppSizes.mp_w_4,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
        vertical: AppSizes.mp_v_2,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius_6),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BouncingButton(
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              size: AppSizes.icon_size_6,
              color: AppColors.gold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Row(
            children: [
              Text(
                "150 ETB",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gold,
                      fontSize: AppSizes.font_10,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: AppSizes.mp_w_2,
              ),
              BouncingButton(
                onPressed: () {},
                child: CircleAvatar(
                  radius: AppSizes.icon_size_6,
                  backgroundColor: AppColors.darkGold,
                  child: CircleAvatar(
                    radius: AppSizes.icon_size_6 * 0.93,
                    backgroundColor: AppColors.lightWhite,
                    backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
