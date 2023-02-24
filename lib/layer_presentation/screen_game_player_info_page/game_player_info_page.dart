import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_get_info/game_get_info_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_start/game_start_bloc.dart';
import 'package:quiz_bet/layer_buisness/cubits/game_start_info_cubit/game_start_info_cubit.dart';
import 'package:quiz_bet/layer_data/models/game_info.dart';
import 'package:quiz_bet/layer_data/models/game_initial_info.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/layer_presentation/common/app_error_widget.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/common/app_loading_widget.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_info_page/widgets/dialog_balance_insufucent.dart';
import 'package:quiz_bet/layer_presentation/screen_game_player_info_page/widgets/dialog_game_confirmation.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:quiz_bet/utils/pages_util.dart';

class GamePlayerInfoPage extends StatefulWidget {
  const GamePlayerInfoPage({Key? key, required this.categoryId})
      : super(key: key);

  final String categoryId;

  @override
  State<GamePlayerInfoPage> createState() => _GamePlayerInfoPageState();
}

class _GamePlayerInfoPageState extends State<GamePlayerInfoPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    context.read<GameGetInfoBloc>().add(
          GetInfoEvent(
            categoryId: widget.categoryId,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///BUILD APP BAR
            buildAppBar(),

            Expanded(
              child: BlocConsumer<GameGetInfoBloc, GameGetInfoState>(
                listener: (context, state) {
                  if (state is GameGetInfoLoadedState) {
                    ///IF USER BALANCE IS ZERO KICK OF GAME STARTING PAGE
                    if (state.gameInitialInfo.balance < 1) {
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
                  }
                },
                builder: (context, state) {
                  ///BUILD LOADING VIEW
                  if (state is GameGetInfoLoadingState) {
                    return const AppLoadingWidget();
                  }

                  ///BUILD LOADING ERROR VIEW
                  if (state is GameGetInfoLoadingErrorState) {
                    return AppErrorWidget(
                      onTryAgain: () {
                        context.read<GameGetInfoBloc>().add(
                              GetInfoEvent(
                                categoryId: widget.categoryId,
                              ),
                            );
                      },
                    );
                  }

                  ///BUILD LOADED VIEW
                  if (state is GameGetInfoLoadedState) {
                    return buildLoadedView(context, state.gameInitialInfo);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack buildLoadedView(BuildContext context, GameInitialInfo gameInitialInfo) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: AppSizes.mp_v_16),
          child: Column(
            children: [
              SizedBox(
                height: AppSizes.mp_v_2,
              ),

              ///BUILD HEADER
              buildHeader(context, gameInitialInfo),

              SizedBox(
                height: AppSizes.mp_v_4,
              ),

              ///BUILD GAME INFO CONTAINER
              buildGameInfoContainer(
                context,
                gameInitialInfo,
              ),

              SizedBox(
                height: AppSizes.mp_v_2,
              ),

              ///BUILD PRIZE INFO CONTAINER
              buildGamepPrizeContainer(context, gameInitialInfo),

              SizedBox(
                height: AppSizes.mp_v_2,
              ),

              ///BUILD BALANCE INFO CONTAINER
              buildGameBalanceContainer(context),
            ],
          ),
        ),

        ///BUILD START BUTTON
        Align(
          alignment: Alignment.bottomCenter,
          child: buildStartButton(context, gameInitialInfo),
        ),
      ],
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
              size: AppSizes.icon_size_4,
              color: AppColors.gold,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Daniel Seyoum",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                "150 ETB".toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          CircleAvatar(
            radius: AppSizes.icon_size_6 * 0.9,
            backgroundColor: AppColors.darkGold,
            child: CircleAvatar(
              radius: AppSizes.icon_size_6 * 0.85,
              backgroundColor: AppColors.lightWhite,
              backgroundImage: const NetworkImage(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
              ),
            ),
          )
        ],
      ),
    );
  }

  buildHeader(BuildContext context, GameInitialInfo gameInitialInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          gameInitialInfo.category.name.nameAm,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          "Question ${gameInitialInfo.levels.first.name.nameAm}",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  buildGameInfoContainer(
      BuildContext context, GameInitialInfo gameInitialInfo) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_v_2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Number of Questions : ${gameInitialInfo.levels.first.questions.length}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_1,
              ),
              Text(
                "Total Odd : ${PagesUtil.getTotalOdd(gameInitialInfo.levels)}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Divider(color: AppColors.grey),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Text(
                "MAX ${gameInitialInfo.balance.toStringAsFixed(2)} BIRR"
                    .toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Material(
                      color: AppColors.lightWhite.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius_6,
                      ),
                      child: TextFormField(
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          context
                              .read<GameStartInfoCubit>()
                              .calculateInitialLevelGameInfo(
                                gameInitialInfo.levels.first.odd,
                                PagesUtil.getAmountToBe(
                                  textEditingController.text,
                                ),
                                gameInitialInfo.vatPercentage,
                                gameInitialInfo.balance,
                              );
                        },
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.dollarSign,
                                size: AppSizes.icon_size_4,
                                color: AppColors.darkGrey,
                              ),
                              SizedBox(
                                width: AppSizes.mp_w_1,
                              ),
                              Text(
                                "BIRR".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(
                                width: AppSizes.mp_w_3,
                              ),
                            ],
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
                            FlutterBeep.beep();

                            ///IF MAX (BALANCE IS REACHED DON'T INCREMENT)
                            if (PagesUtil.getIncrementedBid(
                                        textEditingController.text)
                                    .toDouble() >
                                gameInitialInfo.balance) {
                              ///CAN ADD MORE
                              AnimatedSnackBar.material(
                                'Balance Limit Reached',
                                type: AnimatedSnackBarType.warning,
                              ).show(context);
                            } else {
                              textEditingController.text =
                                  "${PagesUtil.getIncrementedBid(textEditingController.text)}";
                              context
                                  .read<GameStartInfoCubit>()
                                  .calculateInitialLevelGameInfo(
                                    gameInitialInfo.levels.first.odd,
                                    PagesUtil.getAmountToBe(
                                      textEditingController.text,
                                    ),
                                    gameInitialInfo.vatPercentage,
                                    gameInitialInfo.balance,
                                  );
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
                            FlutterBeep.beep();
                            textEditingController.text =
                                "${PagesUtil.getDescrimentedBid(textEditingController.text)}";
                            context
                                .read<GameStartInfoCubit>()
                                .calculateInitialLevelGameInfo(
                                  gameInitialInfo.levels.first.odd,
                                  PagesUtil.getAmountToBe(
                                    textEditingController.text,
                                  ),
                                  gameInitialInfo.vatPercentage,
                                  gameInitialInfo.balance,
                                );
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
                    width: AppSizes.mp_w_10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildGamepPrizeContainer(
      BuildContext context, GameInitialInfo gameInitialInfo) {
    return BlocBuilder<GameStartInfoCubit, GameStartInfoState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
          child: AppCard(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_4,
                vertical: AppSizes.mp_v_2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Winning Prize",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_2,
                  ),
                  buildInfoItem(
                    context,
                    "Deposit",
                    "${(state is InitialLevelGameInfoCalculated) ? state.deposit : '--'} ETB",
                    AppColors.darkBlue,
                  ),
                  SizedBox(height: AppSizes.mp_v_1),
                  buildInfoItem(
                    context,
                    "VAT ${gameInitialInfo.vatPercentage}%",
                    "${(state is InitialLevelGameInfoCalculated) ? state.vat : '--'} ETB",
                    AppColors.darkBlue,
                  ),
                  SizedBox(height: AppSizes.mp_v_1),
                  buildInfoItem(
                    context,
                    "Placed Bet",
                    "${(state is InitialLevelGameInfoCalculated) ? state.placedBet : '--'} ETB",
                    AppColors.darkBlue,
                  ),
                  SizedBox(height: AppSizes.mp_v_1),
                  buildInfoItem(
                    context,
                    "Total Odd",
                    "${(state is InitialLevelGameInfoCalculated) ? state.totalOdd : '--'} ETB",
                    AppColors.darkBlue,
                  ),
                  SizedBox(height: AppSizes.mp_v_1),
                  buildInfoItem(
                    context,
                    "To Win",
                    "${(state is InitialLevelGameInfoCalculated) ? state.toWin : '--'} ETB",
                    AppColors.darkGold,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildGameBalanceContainer(BuildContext context) {
    return BlocBuilder<GameStartInfoCubit, GameStartInfoState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
          child: AppCard(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_4,
                vertical: AppSizes.mp_v_2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_2,
                  ),
                  buildInfoItem(
                    context,
                    "Account Amount",
                    "${(state is InitialLevelGameInfoCalculated) ? state.accountAmount : '--'} ETB",
                    AppColors.darkBlue,
                  ),
                  SizedBox(height: AppSizes.mp_v_1),
                  buildInfoItem(
                    context,
                    "Deducted",
                    "${(state is InitialLevelGameInfoCalculated) ? state.deducted : '--'} ETB",
                    AppColors.darkBlue,
                  ),
                  SizedBox(height: AppSizes.mp_v_1),
                  buildInfoItem(
                    context,
                    "Remaining",
                    "${(state is InitialLevelGameInfoCalculated) ? state.remaining : '--'} ETB",
                    AppColors.gold,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  buildStartButton(BuildContext context, GameInitialInfo gameInitialInfo) {
    return BlocBuilder<GameStartInfoCubit, GameStartInfoState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.2),
                offset: const Offset(0, 0),
                blurRadius: 12.0,
                spreadRadius: 8.0,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_8,
            vertical: AppSizes.mp_v_4,
          ),
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
              if (state is InitialLevelGameInfoCalculated) {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return MultiRepositoryProvider(
                      providers: [
                        RepositoryProvider(
                          create: (context) => GamePageRepository(
                            service: GamePageService(),
                          ),
                        ),
                        RepositoryProvider(
                          create: (context) => AuthPageRepository(
                            service: AuthPageService(),
                          ),
                        ),
                      ],
                      child: BlocProvider(
                        create: (context) => GameStartBloc(
                          gamePageRepository:
                              context.read<GamePageRepository>(),
                          authPageRepository:
                              context.read<AuthPageRepository>(),
                        ),
                        child: DialogGameConfirmation(
                          gameInitialInfo: gameInitialInfo,
                          amountToBet: int.parse(state.placedBet.split('.')[0]),
                          vatPer: double.parse(state.vat),
                        ),
                      ),
                    );
                  },
                );
              } else {
                ///CAN ADD MORE
                AnimatedSnackBar.material(
                  'Insufficient amount',
                  type: AnimatedSnackBarType.warning,
                ).show(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Start',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontSize: AppSizes.font_12,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  width: AppSizes.mp_w_2,
                ),
                Icon(
                  FontAwesomeIcons.solidCircleChevronRight,
                  size: AppSizes.icon_size_4,
                  color: AppColors.gold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
