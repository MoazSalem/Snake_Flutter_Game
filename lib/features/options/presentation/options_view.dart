import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/localization.dart';
import 'widgets/options_view_body.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppLocalization.optionScreenTitle),
          centerTitle: true,
          toolbarHeight: AppSizes.appBarSize),
      body: const OptionsViewBody(),
    );
  }
}
