import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/assets.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/core/utils/constants.dart';
import 'package:snake/features/leaderboard/presentation/cubit/leaderboard_cubit.dart';
import 'package:snake/features/game/presentation/cubit/game_cubit.dart';

TextEditingController _controller = TextEditingController();
gameOver(BuildContext context) {
  // play game over sound
  getIt.get<GameCubit>().playAudio(audio: AssetsData.gameOverAudio);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You Hit Yourself!'),
              Text('Your Score: ${getIt.get<GameCubit>().state.score}'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Exit')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  saveScore(context);
                },
                child: const Text('Save Score')),
          ],
        );
      });
}

saveScore(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To Leaderboard'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter Your Name'),
            onChanged: (value) {
              _controller.text = value;
            },
          ),
          actions: [
            BlocProvider(
              create: (context) => LeaderboardCubit(),
              child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
                builder: (context, state) {
                  return TextButton(
                      onPressed: () {
                        BlocProvider.of<LeaderboardCubit>(context)
                            .addToLeaderboard(
                                newItem: LeaderboardItem(
                                    name: _controller.text,
                                    difficulty: GameValues.difficultyNames[getIt
                                        .get<GameCubit>()
                                        .state
                                        .difficultyIndex],
                                    score: getIt.get<GameCubit>().state.score,
                                    width: Hive.box('optionsBox').get('boardWidth',
                                        defaultValue:
                                            (getIt
                                                        .get<Size>()
                                                        .width *
                                                    0.036)
                                                .toInt()),
                                    height: Hive.box('optionsBox').get(
                                        'boardHeight',
                                        defaultValue:
                                            ((getIt.get<Size>().width * 0.036) *
                                                    1.7)
                                                .toInt())));
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'));
                },
              ),
            ),
          ],
        );
      });
}
