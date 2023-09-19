import 'package:flutter/material.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/features/game/presentation/widgets/game_board_view.dart';
import 'controller.dart';

class GameViewBody extends StatefulWidget {
  const GameViewBody({Key? key}) : super(key: key);

  @override
  State<GameViewBody> createState() => _GameViewBodyState();
}

class _GameViewBodyState extends State<GameViewBody> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: GameBoardView(),
        ),
        Controller(),
      ],
    );
  }
}
