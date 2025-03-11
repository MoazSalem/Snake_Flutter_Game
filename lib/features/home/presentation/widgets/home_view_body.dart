import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/routes.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    getIt.registerSingleton<OptionsCubit>(OptionsCubit.get(context));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: AppSizes.buttonWidth,
              width: AppSizes.buttonWidth,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.difficultyScreen),
                  child: const Text(
                    'Start Game',
                    style: TextStyle(fontSize: AppSizes.largeTitleSize),
                  ))),
          const SizedBox(height: AppSizes.divider),
          SizedBox(
              height: AppSizes.buttonHeight,
              width: AppSizes.buttonWidth,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.leaderScreen),
                  child: const Text('Leaderboard'))),
          const SizedBox(height: AppSizes.divider),
          SizedBox(
              height: AppSizes.buttonHeight,
              width: AppSizes.buttonWidth,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.optionsScreen),
                  child: const Text('Options'))),
        ],
      ),
    );
  }
}
