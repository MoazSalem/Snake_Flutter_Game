import 'package:flutter/material.dart';
import 'board_size_controller.dart';
import 'game_board.dart';

class GameBoardSizeViewBody extends StatelessWidget {
  const GameBoardSizeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          GameBoardWidget(),
          Expanded(child: BoardSizeController()),
        ],
      ),
    );
  }
}
