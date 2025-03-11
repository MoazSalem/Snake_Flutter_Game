import 'package:flutter/material.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/core/utils/routes.dart';
import 'package:snake/features/options/presentation/widgets/options_tile.dart';

class OptionsViewBody extends StatelessWidget {
  const OptionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OptionsTile(title: AppLocalization.gameBoardSize, goTo: AppRoutes.gameBoardSizeScreen),
        OptionsTile(title: AppLocalization.gameControllerStyle, goTo: AppRoutes.gameControllerStyleScreen),
      ],
    );
  }
}
