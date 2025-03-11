import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/features/difficulty/presentation/widgets/difficulty_view_body.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppLocalization.difficultyScreenTitle),
          centerTitle: true,
          toolbarHeight: AppSizes.appBarSize),
      body: const DifficultyViewBody(),
    );
  }
}
