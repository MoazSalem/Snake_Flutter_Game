import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/game/presentation/view_modal/game_cubit/game_cubit.dart';

class GamePoint extends StatelessWidget {
  final GameBoard gameBoard;
  final int index;
  const GamePoint({super.key, required this.gameBoard, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
  builder: (context, state) {
    return Container(
        width: AppSizes.screenDotSize,
        height: AppSizes.screenDotSize,
        color: getColor(
            index % gameBoard.width, index ~/ gameBoard.width, gameBoard));
  },
);
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
        return getIt.get<ColorScheme>().onSecondary.withValues(alpha: 0.6);
      }
  }
}
