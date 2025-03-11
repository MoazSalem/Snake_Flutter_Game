import 'package:flutter/material.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/app_sizes.dart';

class LeaderboardTile extends StatelessWidget {
  final LeaderboardItem item;
  final int position;
  const LeaderboardTile(
      {super.key, required this.item, required this.position});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.verticalPadding),
        horizontalTitleGap: AppSizes.verticalPadding,
        minVerticalPadding: AppSizes.verticalPadding,
        leading: Text(
          position.toString(),
          style: const TextStyle(
              fontSize: AppSizes.largeTitleSize, color: Colors.white),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontSize: AppSizes.largeTitleSize,
          ),
        ),
        trailing: Text(
          item.score.toString(),
          style: TextStyle(
              fontSize: AppSizes.largeTitleSize,
              color: (position == 1 || position == 2 || position == 3)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface),
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
