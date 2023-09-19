import 'point.dart';

class Snake {
  List<Point> body = [];
  late Point headPoint;

  Snake({required int boardWidth, required int boardHeight}) {
    // randomly generate the snake's head and body position
    headPoint = generateRandomPosition(boardWidth, boardHeight);
    body.add(Point(xCoordinate: headPoint.xCoordinate, yCoordinate: headPoint.yCoordinate + 1));
  }

  void move() {
    // Update the snake's body coordinates based on its direction
  }

  void changeDirection(Point nextPoint) {
    headPoint = nextPoint;
  }

  void checkCollision() {
    // Check if the snake has collided with itself or the boundaries of the game board
  }
}
