import 'package:flutter/material.dart';
import 'package:snake/features/options/presentation/inner_features/game_controller_style/presentation/widgets/game_controller_style_view_body.dart';

class GameControllerStyleView extends StatelessWidget {
  const GameControllerStyleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Game Controller Style'), centerTitle: true, toolbarHeight: 70),
        body: const GameControllerStyleViewBody());
  }
}
