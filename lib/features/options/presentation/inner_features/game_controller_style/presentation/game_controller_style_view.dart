import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/features/options/presentation/inner_features/game_controller_style/presentation/widgets/game_controller_style_view_body.dart';

class GameControllerStyleView extends StatelessWidget {
  const GameControllerStyleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppLocalization.gameControllerStyle),
            centerTitle: true,
            toolbarHeight: AppSizes.appBarSize),
        body: const GameControllerStyleViewBody());
  }
}
