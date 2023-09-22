import 'package:flutter/material.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/utils/service_locator.dart';

class GamePoint extends StatelessWidget {
  final GameBoard gameBoard;
  final int index;
  const GamePoint({Key? key, required this.gameBoard, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10,
        height: 10,
        color: getColor(index % gameBoard.width, index ~/ gameBoard.width, gameBoard));
  }
}

Color getColor(int x, int y, GameBoard gameBoard) {
  switch (gameBoard.grid[y][x]) {
    case 1:
      {
        return Colors.redAccent;
      }
    case 2:
      {
        return getIt.get<ColorScheme>().secondary;
      }
    case 3:
      {
        return getIt.get<ColorScheme>().primary;
      }
    case 4:
      {
        return Colors.amberAccent;
      }
    default:
      {
        return getIt.get<ColorScheme>().onSecondary.withOpacity(0.6);
      }
  }
}
