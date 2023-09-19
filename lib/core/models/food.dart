import 'point.dart';

class Food {
  late Point position;

  Food({required int boardWidth, required int boardHeight}) {
    position = generateRandomPosition(boardWidth, boardHeight);
  }

  void draw() {
    // Draw the food on the game board
  }

  bool checkEaten(Point snakeHead) {
    return position == snakeHead;
  }
}
