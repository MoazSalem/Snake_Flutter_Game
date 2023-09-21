import 'package:hive/hive.dart';

part 'leaderboard_item.g.dart';

@HiveType(typeId: 0)
class LeaderboardItem extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String difficulty;
  @HiveField(2)
  int score;
  @HiveField(3)
  int width;
  @HiveField(4)
  int height;
  LeaderboardItem(
      {required this.name,
      required this.difficulty,
      required this.score,
      required this.width,
      required this.height});
}
