part of 'leaderboard_cubit.dart';

class LeaderboardState {
  final Map<String, List<LeaderboardItem>> leaderboard;
  final bool isLoading;
  final DateTime? lastUpdated;
  final Map<String, Timestamp> leaderboardTimestamps;
  final String currentDifficulty;

  LeaderboardState({
    required this.leaderboard,
    required this.isLoading,
    required this.lastUpdated,
    required this.leaderboardTimestamps,
    required this.currentDifficulty,
  });

  LeaderboardState copyWith({
    Map<String, List<LeaderboardItem>>? leaderboard,
    bool? isLoading,
    DateTime? lastUpdated,
    Map<String, Timestamp>? leaderboardTimestamps,
    String? currentDifficulty,
  }) {
    return LeaderboardState(
      leaderboard: leaderboard ?? this.leaderboard,
      isLoading: isLoading ?? this.isLoading,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      leaderboardTimestamps: leaderboardTimestamps ?? this.leaderboardTimestamps,
      currentDifficulty: currentDifficulty ?? this.currentDifficulty,
    );
  }
}