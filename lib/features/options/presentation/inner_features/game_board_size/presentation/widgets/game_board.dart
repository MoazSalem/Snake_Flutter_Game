import 'package:flutter/material.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/features/game/presentation/widgets/game_point.dart';

class GameBoardWidget extends StatelessWidget {
  const GameBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameBoard gameBoard = GameBoard(width: 13, height: 24);
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        itemCount: 13 * 24,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(24 / 13),
              child: GamePoint(gameBoard: gameBoard, index: index));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gameBoard.width,
        ));
    ;
  }
}
