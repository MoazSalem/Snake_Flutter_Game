import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/constants.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/features/leaderboard/presentation/cubit/leaderboard_cubit.dart';

import 'leaderboard_list.dart';

class LeaderboardViewBody extends StatefulWidget {
  const LeaderboardViewBody({super.key});

  @override
  State<LeaderboardViewBody> createState() => _LeaderboardViewBodyState();
}

class _LeaderboardViewBodyState extends State<LeaderboardViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: GameValues.difficultyNames.length, vsync: this);
    LeaderboardCubit.get(context).refreshLeaderboard();

    // Listen to tab changes and update the cubit's state
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final difficulty = GameValues.difficultyNames[_tabController.index];
        LeaderboardCubit.get(context).setDifficulty(difficulty);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLocalization.leaderScreenTitle),
        actions: [
          // Refresh button
          BlocBuilder<LeaderboardCubit, LeaderboardState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: state.isLoading
                    ? null
                    : () => LeaderboardCubit.get(context)
                        .refreshLeaderboard(forceRefresh: true),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true, // Make tabs scrollable
              tabAlignment: TabAlignment.center,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              tabs: GameValues.difficultyNames
                  .map((difficulty) => Tab(
                child: Text(
                  difficulty,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ))
                  .toList(),
              onTap: (index) {
                final difficulty = GameValues.difficultyNames[index];
                LeaderboardCubit.get(context).setDifficulty(difficulty);
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Sync tab controller with state's currentDifficulty
          BlocListener<LeaderboardCubit, LeaderboardState>(
            listenWhen: (previous, current) =>
                previous.currentDifficulty != current.currentDifficulty,
            listener: (context, state) {
              final index =
                  GameValues.difficultyNames.indexOf(state.currentDifficulty);
              if (index != -1 && index != _tabController.index) {
                _tabController.animateTo(index);
              }
            },
            child: const SizedBox.shrink(),
          ),

          // Loading indicator
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
            child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // Leaderboard content
          Expanded(
            child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
              buildWhen: (previous, current) =>
                  previous.leaderboard != current.leaderboard ||
                  previous.currentDifficulty != current.currentDifficulty,
              builder: (context, state) {
                final leaderboardItems =
                    LeaderboardCubit.get(context).getCurrentLeaderboard();
                if (leaderboardItems.isEmpty) {
                  return Center(
                    child: Text(AppLocalization.noRecords),
                  );
                }

                return LeaderboardList(leaderboardItems: leaderboardItems);
              },
            ),
          ),
          // Last updated time
          BlocBuilder<LeaderboardCubit, LeaderboardState>(
            buildWhen: (previous, current) =>
                previous.lastUpdated != current.lastUpdated,
            builder: (context, state) {
              final lastUpdated = state.lastUpdated;
              return Padding(
                padding: EdgeInsets.all(AppSizes.topPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      lastUpdated != null
                          ? '${AppLocalization.lastUpdated} ${DateFormat('MMM d, yyyy HH:mm').format(lastUpdated)}'
                          : AppLocalization.neverUpdated,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
