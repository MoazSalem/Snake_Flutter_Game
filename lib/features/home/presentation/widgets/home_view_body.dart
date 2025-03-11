import 'package:flutter/material.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key}) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 240,
                width: 240,
                child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/difficulty'),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(fontSize: 24),
                    ))),
            const SizedBox(height: 16),
            SizedBox(
                height: 60,
                width: 240,
                child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
                    child: const Text('Leaderboard'))),
            const SizedBox(height: 16),
            SizedBox(
                height: 60,
                width: 240,
                child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/options'),
                    child: const Text('Options'))),
          ],
        ),
      ),
    );
  }
}
