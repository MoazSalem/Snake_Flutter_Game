import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/constants.dart';
import 'button_widget.dart';

class DifficultyViewBody extends StatelessWidget {
  const DifficultyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWidget(
                text: GameValues.difficultyNames[0],
                difficultyType: 0,
              ),
              ButtonWidget(
                text: GameValues.difficultyNames[1],
                difficultyType: 1,
              ),
              ButtonWidget(
                text: GameValues.difficultyNames[2],
                difficultyType: 2,
              ),
              ButtonWidget(
                text: GameValues.difficultyNames[3],
                difficultyType: 3,
              ),
              ButtonWidget(
                text: GameValues.difficultyNames[4],
                difficultyType: 4,
              ),
            ]),
      ),
    );
  }
}
