import 'package:flutter/material.dart';
import 'controller.dart';

class GameViewBody extends StatefulWidget {
  const GameViewBody({Key? key}) : super(key: key);

  @override
  State<GameViewBody> createState() => _GameViewBodyState();
}

class _GameViewBodyState extends State<GameViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
        ),
        const Controller(),
      ],
    );
  }
}
