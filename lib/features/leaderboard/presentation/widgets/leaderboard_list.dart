import 'package:flutter/material.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/app_sizes.dart';

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardItem> leaderboardItems;

  const LeaderboardList({super.key, required this.leaderboardItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallerPadding),
      itemCount: leaderboardItems.length,
      itemBuilder: (context, index) {
        final item = leaderboardItems[index];
        final color = index < 3 ? _getTopColor(index) : null;
        return Card(
          elevation: 4,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surfaceDim,
              foregroundColor: color,
              radius: 24,
              child: Text(
                '${index + 1}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            title: Text(
              item.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.largeTitleSize,
                  color: color),
            ),
            subtitle: Text('${item.width}×${item.height} grid'),
            trailing: Text('${item.score}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.largeTitleSize,
                  color: color,
                )),
          ),
        );
      },
    );
  }

  Color _getTopColor(int index) {
    switch (index) {
      case 0:
        return Colors.yellow.shade600; // Gold
      case 1:
        return Colors.grey.shade300; // Silver
      case 2:
        return Colors.brown.shade300; // Bronze
      default:
        return Colors.transparent;
    }
  }
}
