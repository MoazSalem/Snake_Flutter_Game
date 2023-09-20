import 'package:flutter/material.dart';
import 'button_widget.dart';

class DifficultyViewBody extends StatelessWidget {
  const DifficultyViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonWidget(
              text: 'Easy',
              difficultyType: 0,
            ),
            ButtonWidget(
              text: 'Normal',
              difficultyType: 1,
            ),
            ButtonWidget(
              text: 'Hard',
              difficultyType: 2,
            ),
            ButtonWidget(
              text: 'Very Hard',
              difficultyType: 3,
            ),
            ButtonWidget(
              text: 'Impossible',
              difficultyType: 4,
            ),
          ]),
    );
  }
}
