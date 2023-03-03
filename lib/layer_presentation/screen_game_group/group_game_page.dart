import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_forfit_winner_listner_subscription/game_group_forfit_winner_listner_subscription_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_joined_subscription/game_group_joined_subscription_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_level_widget/game_group_level_widget_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_main_page/game_group_main_page_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_group_info.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/widgets/game_group_level_widget.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/widgets/item_group_game_levels_compileted.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/widgets/item_group_game_you_won.dart';

class GroupGamePage extends StatefulWidget {
  const GroupGamePage({Key? key, required this.gameGroupInfo})
      : super(key: key);

  final GameGroupInfo gameGroupInfo;

  @override
  State<GroupGamePage> createState() => _GroupGamePageState();
}

class _GroupGamePageState extends State<GroupGamePage> {
  @override
  void initState() {
    ///START PLAYING
    context.read<GameGroupMainPageBloc>().add(
          StartGroupGameLevel(),
        );

    context.read<GameGroupForfeitWinnerListenerSubscriptionBloc>().add(
          StartGameGroupForfitWinnerEvent(),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<GameGroupForfeitWinnerListenerSubscriptionBloc,
            GameGroupForfitWinnerListnerSubscriptionState>(
          listener: (context, state) {
            if (state is GameGroupPlayerWinnerState) {
              AnimatedSnackBar.rectangle(
                "You Won",
                "Congratulations you have beaten all players",
                type: AnimatedSnackBarType.success,
              ).show(context);
            }

            if (state is GameGroupForfitShowNotificationState) {
              for (var element in state.showForfitNotifyList) {
                AnimatedSnackBar.rectangle(
                  "Player Defeated",
                  "${element.userName} has lost this game",
                  type: AnimatedSnackBarType.info,
                ).show(context);
              }
            }
          },
          buildWhen: (prevStat,state){
            if (state is GameGroupPlayerWinnerState) {
              return  true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is GameGroupPlayerWinnerState) {
              return  ItemGroupGameYouWon(
                winningPrize: state.winningPrize,
                numberOfPlayers: state.numberOfPlayers,
                placedBet: state.placedBet,
                vatPer: state.vatPer,
                vatDeducted: state.vatDeducted,
              );
            }

            return buildMainView();
          },
        ),
      ),
    );
  }

  buildMainView() {
    return BlocBuilder<GameGroupMainPageBloc, GameGroupMainPageState>(
      builder: (context, state) {
        if (state is GameGroupPlayLevelDoneState) {
          return const ItemGroupGameLevelsCompilited();
        }

        if (state is GameGroupPlayLevelState) {
          return BlocProvider(
            key: Key(state.gameLevel.id),
            create: (context) =>
                GameGroupLevelWidgetBloc(gameLevel: state.gameLevel),
            child: GameGroupLevelWidget(
              key: Key(state.gameLevel.id),
              gameLevel: state.gameLevel,
              groupQuizId: widget.gameGroupInfo.groupQuizId,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
