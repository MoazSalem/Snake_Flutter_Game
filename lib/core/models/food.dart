import 'point.dart';

class Food {
  late Point position;

  Food({required int boardWidth, required int boardHeight}) {
    // randomly generate the food's position
    position = generateRandomPosition(boardWidth, boardHeight);
  }

  bool checkEaten(Point snakeHead) {
    return (position.xCoordinate == snakeHead.xCoordinate &&
        position.yCoordinate == snakeHead.yCoordinate);
  }
}
