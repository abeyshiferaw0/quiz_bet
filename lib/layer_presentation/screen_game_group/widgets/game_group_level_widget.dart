import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_level_widget/game_group_level_widget_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_main_page/game_group_main_page_bloc.dart';
import 'package:quiz_bet/layer_buisness/blocs/bloc_game_group/bloc_game_group_question_item/game_group_question_item_bloc.dart';
import 'package:quiz_bet/layer_data/models/game_level.dart';
import 'package:quiz_bet/layer_data/repositories/repository_auth_page.dart';
import 'package:quiz_bet/layer_data/repositories/repository_game_page.dart';
import 'package:quiz_bet/layer_data/services/service_auth_page.dart';
import 'package:quiz_bet/layer_data/services/service_game_page.dart';
import 'package:quiz_bet/layer_presentation/common/app_feedback_button.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/widgets/item_group_game_next_level_count_down.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/widgets/item_group_game_player_forfit_card.dart';
import 'package:quiz_bet/layer_presentation/screen_game_group/widgets/item_group_game_question_card.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class GameGroupLevelWidget extends StatefulWidget {
  const GameGroupLevelWidget(
      {Key? key, required this.gameLevel, required this.groupQuizId})
      : super(key: key);

  final GameLevel gameLevel;
  final String groupQuizId;

  @override
  State<GameGroupLevelWidget> createState() => _GameGroupLevelWidgetState();
}

class _GameGroupLevelWidgetState extends State<GameGroupLevelWidget> {
  @override
  void initState() {

    print("CURENT LEVEL UI => ${widget.gameLevel.id}");

    context.read<GameGroupLevelWidgetBloc>().add(
          GameGroupLevelStartQuestionsEvent(),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ///APP BAR
          buildAppBar(context),

          ///BUILD QUESTION ITEM
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
              child: BlocBuilder<GameGroupLevelWidgetBloc,
                  GameGroupLevelWidgetState>(
                builder: (context, state) {
                  if (state is GameGroupQuesetionsDoneState) {
                    return ItemGroupGameNextLevelCountDown(
                      onCountDownFinished: () {
                        ///GO TO NEXT LEVEL
                        context
                            .read<GameGroupMainPageBloc>()
                            .add(NextGroupGameLevel());
                      },
                    );
                  }

                  if (state is GameGroupQuesetionsPlayerForfitState) {
                    return ItemGroupGamePlayerForfitCard();
                  }

                  if (state is GameGroupAskQuesetionState) {
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
                        create: (context) => GameGroupQuestionItemBloc(
                          gameQuestion: state.gameQuestion,
                          gamePageRepository:
                              context.read<GamePageRepository>(),
                          authPageRepository:
                              context.read<AuthPageRepository>(),
                        ),
                        child: ItemGroupGameQuestion(
                          key: Key(state.gameQuestion.id),
                          gameQuestion: state.gameQuestion,
                          questionNumber: state.questionNumber,
                          questionId: state.gameQuestion.id,
                          groupQuizId: widget.groupQuizId,
                        ),
                      ),
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildAppBar(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_1,
        //horizontal: AppSizes.mp_w_4,
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
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.gameLevel.name.nameAm,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font_12,
                      ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 2,
                ),
                SizedBox(
                  height: AppSizes.icon_size_2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius_12),
                    ),
                    child: BlocBuilder<GameGroupLevelWidgetBloc,
                        GameGroupLevelWidgetState>(
                      builder: (context, state) {

                        int curIndex = context.read<GameGroupLevelWidgetBloc>().currentQuestionIndex+1;
                        int totalLength = widget.gameLevel.questions.length;

                        print("GameGroupAskQuesetionState=>> $curIndex $totalLength");

                        return LinearProgressIndicator(
                          value: ((curIndex * 100) / totalLength) / 100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.green,
                          ),
                          backgroundColor: AppColors.lightGrey,
                        );

                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.mp_v_1 / 3,
                ),
                BlocBuilder<GameGroupLevelWidgetBloc,
                    GameGroupLevelWidgetState>(
                  builder: (context, state) {

                    int curIndex = context.read<GameGroupLevelWidgetBloc>().currentQuestionIndex+1;
                    int totalLength = widget.gameLevel.questions.length;

                    return Text(
                      "Questions $curIndex/$totalLength",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gold,
                        fontSize: AppSizes.font_9,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          AppButtonFeedBack(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.mp_w_2),
              child: Icon(
                FontAwesomeIcons.xmark,
                size: AppSizes.icon_size_6,
                color: AppColors.gold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: AppSizes.mp_w_1,
          ),
        ],
      ),
    );
  }
}
