import 'package:flutter/material.dart';
import 'package:snake/core/models/leaderboard_item.dart';

class LeaderboardTile extends StatelessWidget {
  final LeaderboardItem item;
  const LeaderboardTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        horizontalTitleGap: 20,
        minVerticalPadding: 20,
        leading: Text(
          item.position.toString(),
          style: const TextStyle(fontSize: 26, color: Colors.white),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
        trailing: Text(
          item.score.toString(),
          style: TextStyle(
              fontSize: 26,
              color: (item.position == 1 || item.position == 2 || item.position == 3)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: item.difficulty),
              TextSpan(
                  text: " (${item.height}x${item.width})",
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ));
  }
}
