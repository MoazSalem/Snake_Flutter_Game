import 'package:flutter/material.dart';
import 'package:snake/core/utils/routes.dart';
import 'package:snake/features/game/presentation/data/screen_arguments.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final int difficultyType;
  const ButtonWidget(
      {super.key, required this.text, required this.difficultyType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 60,
          width: 240,
          child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.gameScreen,
                  arguments: ScreenArguments(difficultyType: difficultyType)),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              ))),
    );
  }
}
