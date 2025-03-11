import 'package:flutter/material.dart';
import 'package:snake/features/options/presentation/widgets/options_tile.dart';

class OptionsViewBody extends StatelessWidget {
  const OptionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        OptionsTile(title: "Game Board Size", goTo: "/GameBoardSize"),
        OptionsTile(title: 'Game Controller Style', goTo: "/GameControllerStyle"),
      ],
    );
  }
}
