import 'package:flutter/material.dart';
import 'widgets/game_view_body.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: GameViewBody()));
  }
}
