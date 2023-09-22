import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/features/home/presentation/widgets/home_view_body.dart';
import 'package:snake/features/leaderboard/presentation/view_modal/leaderboard_cubit/leaderboard_cubit.dart';
import 'package:snake/features/options/presentation/view_modal/options_cubit/options_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, state) {
        return BlocBuilder<LeaderboardCubit, LeaderboardState>(
          builder: (context, state) {
            return const Scaffold(
              body: HomeViewBody(),
            );
          },
        );
      },
    );
  }
}
