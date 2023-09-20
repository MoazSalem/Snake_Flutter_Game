import 'package:flutter/material.dart';
import 'widgets/game_board_size_view_body.dart';

class GameBoardSizeView extends StatelessWidget {
  const GameBoardSizeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Game Board Size'), centerTitle: true, toolbarHeight: 70),
        body: const GameBoardSizeViewBody());
  }
}
