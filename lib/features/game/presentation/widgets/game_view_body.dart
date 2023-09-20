import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/game/presentation/view_modal/game_cubit/game_cubit.dart';
import 'package:snake/features/game/presentation/widgets/score_widget.dart';
import 'game_board_view.dart';
import 'controller.dart';

class GameViewBody extends StatelessWidget {
  const GameViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listener: (context, state) {
        state is GameOver ? gameOver(context) : null;
      },
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GameBoardView(
                width: (getIt.get<Size>().width * 0.036).toInt(),
                height: ((getIt.get<Size>().width * 0.036) * 1.7).toInt(),
              ),
            ),
            const ScoreWidget(),
            const Controller(),
          ],
        ),
      ),
    );
  }
}

gameOver(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('You Hit Yourself!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Exit')),
          ],
        );
      });
}
