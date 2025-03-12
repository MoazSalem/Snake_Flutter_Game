part of 'game_cubit.dart';

class GameState {
  final GameBoard gameBoard;
  final Snake snake;
  final Food food;
  final Food? specialFood;
  final bool game;
  final int score;
  final int difficultyIndex;
  final Duration difficultyDuration;
  final int counter;
  final bool highScore;
  final String currentDirection;
  final String upcomingDirection;
  GameState(
      {required this.gameBoard,
      required this.snake,
      required this.food,
      required this.specialFood,
      required this.game,
      required this.score,
      required this.difficultyIndex,
      required this.difficultyDuration,
      required this.counter,
      required this.highScore,
      required this.currentDirection,
      required this.upcomingDirection});

  GameState copyWith({
    GameBoard? gameBoard,
    Snake? snake,
    Food? food,
    Food? specialFood,
    bool? game,
    int? score,
    int? difficultyIndex,
    Duration? difficultyDuration,
    int? counter,
    bool? highScore,
    String? currentDirection,
    String? upcomingDirection,
  }) {
    return GameState(
      gameBoard: gameBoard ?? this.gameBoard,
      snake: snake ?? this.snake,
      food: food ?? this.food,
      specialFood: this.specialFood == null
          ? specialFood
          : this.counter > 0
              ? this.specialFood
              : specialFood,
      game: game ?? this.game,
      score: score ?? this.score,
      difficultyIndex: difficultyIndex ?? this.difficultyIndex,
      difficultyDuration: difficultyDuration ?? this.difficultyDuration,
      counter: counter ?? this.counter,
      highScore: highScore ?? this.highScore,
      currentDirection: currentDirection ?? this.currentDirection,
      upcomingDirection: upcomingDirection ?? this.upcomingDirection,
    );
  }
}
