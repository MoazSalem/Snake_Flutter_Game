import 'package:flutter/material.dart';
import 'package:snake/features/game/presentation/data/screen_arguments.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final int difficultyType;
  const ButtonWidget({Key? key, required this.text, required this.difficultyType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 60,
          child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/game',
                  arguments: ScreenArguments(difficultyType: difficultyType)),
              child: Text(text))),
    );
  }
}
