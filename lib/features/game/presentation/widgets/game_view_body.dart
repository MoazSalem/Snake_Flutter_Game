import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_modal/game_cubit/game_cubit.dart';
import 'dialogs.dart';
import 'score_widget.dart';
import 'game_board_view.dart';
import 'controller.dart';

class GameViewBody extends StatelessWidget {
  const GameViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listener: (context, state) {
        state.game == false ? gameOver(context) : null;
      },
      child: const SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GameBoardView(),
            ),
            ScoreWidget(),
            Controller(),
          ],
        ),
      ),
    );
  }
}
