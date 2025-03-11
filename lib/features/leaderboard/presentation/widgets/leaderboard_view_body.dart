import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/constants.dart';
import 'package:snake/core/utils/localization.dart';
import 'leaderboard_tile.dart';

late TabController _controller;

class LeaderboardViewBody extends StatefulWidget {
  const LeaderboardViewBody({super.key});

  @override
  State<LeaderboardViewBody> createState() => _LeaderboardViewBodyState();
}

class _LeaderboardViewBodyState extends State<LeaderboardViewBody>
    with TickerProviderStateMixin {
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
      appBar: AppBar(
          title: const Text(AppLocalization.leaderScreenTitle),
          centerTitle: true,
          toolbarHeight: AppSizes.appBarSize),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.smallerPadding),
            child: SegmentedTabControl(
              controller: _controller,
              textStyle: const TextStyle(fontSize: AppSizes.smallerPadding),
              barDecoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.surface),
              indicatorDecoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              tabTextColor: Colors.grey,
              selectedTabTextColor: Theme.of(context).colorScheme.onPrimary,
              height: AppSizes.leaderboardTabHeight,
              tabs: [
                SegmentTab(label: GameValues.difficultyNames[0], flex: 2),
                SegmentTab(label: GameValues.difficultyNames[1], flex: 2),
                SegmentTab(label: GameValues.difficultyNames[2], flex: 2),
                SegmentTab(label: GameValues.difficultyNames[3], flex: 3),
                SegmentTab(label: GameValues.difficultyNames[4], flex: 3),
              ],
            ),
          ),
          (Hive.box('leaderBoardBox').get(
                          "${GameValues.difficultyNames[_controller.index]}List") !=
                      null &&
                  Hive.box('leaderBoardBox')
                      .get(
                          "${GameValues.difficultyNames[_controller.index]}List")
                      .isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: Hive.box('leaderBoardBox')
                      .get(
                          "${GameValues.difficultyNames[_controller.index]}List")!
                      .length,
                  itemBuilder: (context, index) {
                    return LeaderboardTile(
                        item: Hive.box('leaderBoardBox').get(
                                "${GameValues.difficultyNames[_controller.index]}List")[
                            index],
                        position: index + 1);
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        child: const Center(
                            child: Text(AppLocalization.noRecords,
                                style:
                                    TextStyle(fontSize: AppSizes.titleSize)))),
                  ],
                ),
        ],
      ),
    );
  }
}
