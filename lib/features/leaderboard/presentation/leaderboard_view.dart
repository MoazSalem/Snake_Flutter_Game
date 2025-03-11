import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/features/leaderboard/presentation/view_modal/leaderboard_cubit/leaderboard_cubit.dart';
import 'widgets/leaderboard_view_body.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaderboardCubit>(
        create: (context) => LeaderboardCubit()..leaderboardSetup(),
        child: const LeaderboardViewBody());
  }
}
