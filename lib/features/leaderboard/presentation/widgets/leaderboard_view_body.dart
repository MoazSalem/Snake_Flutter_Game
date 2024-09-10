import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/features/constants.dart';
import 'leaderboard_tile.dart';

late TabController _controller;

class LeaderboardViewBody extends StatefulWidget {
  const LeaderboardViewBody({Key? key}) : super(key: key);

  @override
  State<LeaderboardViewBody> createState() => _LeaderboardViewBodyState();
}

class _LeaderboardViewBodyState extends State<LeaderboardViewBody> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard'), centerTitle: true, toolbarHeight: 70),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SegmentedTabControl(
              controller: _controller,
              tabPadding: const EdgeInsets.symmetric(horizontal: 0),
              textStyle: const TextStyle(fontSize: 12),
              barDecoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
              indicatorDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              tabTextColor: Colors.grey,
              selectedTabTextColor: Theme.of(context).colorScheme.onPrimary,
              height: 40,
              tabs: const [
                SegmentTab(label: 'Easy', flex: 2),
                SegmentTab(label: 'Normal', flex: 2),
                SegmentTab(label: 'Hard', flex: 2),
                SegmentTab(label: 'Very Hard', flex: 3),
                SegmentTab(label: 'Impossible', flex: 3),
              ],
            ),
          ),
          (Hive.box('leaderBoardBox').get("${kDifficultyNames[_controller.index]}List") != null &&
                  Hive.box('leaderBoardBox')
                      .get("${kDifficultyNames[_controller.index]}List")
                      .isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: Hive.box('leaderBoardBox')
                      .get("${kDifficultyNames[_controller.index]}List")!
                      .length,
                  itemBuilder: (context, index) {
                    return LeaderboardTile(
                        item: Hive.box('leaderBoardBox')
                            .get("${kDifficultyNames[_controller.index]}List")[index],
                        position: index + 1);
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        child: const Center(
                            child: Text('No Records Yet', style: TextStyle(fontSize: 20)))),
                  ],
                ),
        ],
      ),
    );
  }
}
