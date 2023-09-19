import 'package:flutter/material.dart';
import 'game_board_view.dart';
import 'controller.dart';

class GameViewBody extends StatelessWidget {
  const GameViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GameBoardView(
            width: (MediaQuery.of(context).size.width * 0.036).toInt(),
            height: ((MediaQuery.of(context).size.width * 0.036) * 1.65).toInt(),
          ),
        ),
        const Controller(),
      ],
    );
  }
}
