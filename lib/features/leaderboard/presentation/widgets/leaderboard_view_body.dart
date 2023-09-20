import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'leaderboard_tile.dart';

class LeaderboardViewBody extends StatelessWidget {
  const LeaderboardViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard'), centerTitle: true, toolbarHeight: 70),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DefaultTabController(
              length: 5,
              child: SegmentedTabControl(
                tabPadding: const EdgeInsets.symmetric(horizontal: 0),
                textStyle: const TextStyle(fontSize: 12),
                backgroundColor: Theme.of(context).colorScheme.background,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabTextColor: Colors.grey,
                selectedTabTextColor: Theme.of(context).colorScheme.onPrimary,
                radius: const Radius.circular(4),
                tabs: const [
                  SegmentTab(label: 'Easy', flex: 2),
                  SegmentTab(label: 'Normal', flex: 2),
                  SegmentTab(label: 'Hard', flex: 2),
                  SegmentTab(label: 'Very Hard', flex: 3),
                  SegmentTab(label: 'Impossible', flex: 3),
                ],
              ),
            ),
          ),
          LeaderboardTile(
              item: LeaderboardItem(
                  name: 'Ahmed',
                  position: 1,
                  score: 1000,
                  width: 14,
                  height: 23,
                  difficulty: 'Easy')),
          LeaderboardTile(
              item: LeaderboardItem(
                  name: 'Ali', position: 2, score: 800, width: 14, height: 23, difficulty: 'Easy')),
          LeaderboardTile(
              item: LeaderboardItem(
                  name: 'Mohammed',
                  position: 3,
                  score: 600,
                  width: 14,
                  height: 23,
                  difficulty: 'Easy')),
          LeaderboardTile(
              item: LeaderboardItem(
                  name: 'Ibrahim',
                  position: 4,
                  score: 400,
                  width: 14,
                  height: 23,
                  difficulty: 'Easy')),
          LeaderboardTile(
              item: LeaderboardItem(
                  name: 'Osama',
                  position: 5,
                  score: 200,
                  width: 14,
                  height: 23,
                  difficulty: 'Easy')),
        ],
      ),
    );
  }
}
