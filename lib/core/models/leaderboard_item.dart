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

  @HiveField(5)
  int uploaded;
  LeaderboardItem(
      {required this.name,
      required this.difficulty,
      required this.score,
      required this.width,
      required this.height,
      this.uploaded = 0});

  LeaderboardItem copyWith({
    String? name,
    String? difficulty,
    int? score,
    int? width,
    int? height,
    int? uploaded,
  }) {
    return LeaderboardItem(
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      score: score ?? this.score,
      width: width ?? this.width,
      height: height ?? this.height,
      uploaded: uploaded ?? this.uploaded,
    );
  }
}
