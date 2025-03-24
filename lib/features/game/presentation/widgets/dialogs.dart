import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/assets.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/core/utils/routes.dart';
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
          title: const Text(AppLocalization.gameOver),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppLocalization.hitText),
              Text(
                  '${AppLocalization.yourScore} ${getIt.get<GameCubit>().state.score}'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(AppRoutes.difficultyScreen));
                },
                child: const Text(AppLocalization.exit)),
            TextButton(
                onPressed: () {
                  saveScore(context);
                },
                child: const Text(AppLocalization.saveScore)),
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
          title: const Text(AppLocalization.addToLeaderboard),
          content: TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: AppLocalization.enterYourName),
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
                            .addScore(
                                newItem: LeaderboardItem(
                                    name: _controller.text,
                                    difficulty: GameValues.difficultyNames[getIt
                                        .get<GameCubit>()
                                        .state
                                        .difficultyIndex],
                                    score: getIt.get<GameCubit>().state.score,
                                    width: getIt
                                        .get<GameCubit>()
                                        .state
                                        .gameBoard
                                        .width,
                                    height: getIt
                                        .get<GameCubit>()
                                        .state
                                        .gameBoard
                                        .height))
                            .then((_) {
                          Navigator.popUntil(context,
                              ModalRoute.withName(AppRoutes.difficultyScreen));
                        });
                      },
                      child: const Text(AppLocalization.save));
                },
              ),
            ),
          ],
        );
      });
}
