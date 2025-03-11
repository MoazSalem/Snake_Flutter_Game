part of 'leaderboard_cubit.dart';

class LeaderboardState {
  final Map<String, List<LeaderboardItem>> leaderboard;
  LeaderboardState({required this.leaderboard});

  LeaderboardState copyWith(
      {required Map<String, List<LeaderboardItem>> leaderboard}) {
    return LeaderboardState(leaderboard: leaderboard);
  }
}
