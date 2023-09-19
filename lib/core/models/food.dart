import 'point.dart';

class Food {
  late Point position;

  Food({required int boardWidth, required int boardHeight}) {
    // randomly generate the food's position
    position = generateRandomPosition(boardWidth, boardHeight);
  }

  void draw() {
    // Draw the food on the game board
  }

  bool checkEaten(Point snakeHead) {
    return position == snakeHead;
  }
}
