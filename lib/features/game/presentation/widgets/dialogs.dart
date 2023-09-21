import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/assets.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/constants.dart';
import '../view_modal/game_cubit/game_cubit.dart';

TextEditingController _controller = TextEditingController();
gameOver(BuildContext context) {
  // play game over sound
  AudioPlayer().play(AssetSource(AssetsData.gameoverAudio));
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
              Text('Your Score: ${getIt.get<GameCubit>().score}'),
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
            TextButton(
                onPressed: () {
                  getIt.get<GameCubit>().addToLeaderboard(
                      newItem: LeaderboardItem(
                          name: _controller.text,
                          difficulty: kDifficultyNames[getIt.get<GameCubit>().difficultyIndex],
                          score: getIt.get<GameCubit>().score,
                          width: Hive.box('optionsBox').get('boardWidth',
                              defaultValue: (getIt.get<Size>().width * 0.036).toInt()),
                          height: Hive.box('optionsBox').get('boardHeight',
                              defaultValue: ((getIt.get<Size>().width * 0.036) * 1.7).toInt())));
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Save')),
          ],
        );
      });
}
