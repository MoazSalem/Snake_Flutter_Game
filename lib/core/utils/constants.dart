// This is the time in milliseconds between each game tick, where index 0 is for easy and 4 is for impossible.
class GameValues{
  static const List<int> difficultySpeeds = [600, 400, 200, 100, 50];
  static const List<String> difficultyNames = ['Easy', 'Normal', 'Hard', 'VeryHard', 'Impossible'];
  static const int specialCounter = 90;
  static const int highScore = 2000;
}
