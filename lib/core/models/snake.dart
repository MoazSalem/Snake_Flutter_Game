import 'point.dart';

class Snake {
  List<Point> body = [];
  late Point headPoint;
  String direction = 'up';

  Snake({required int boardWidth, required int boardHeight}) {
    // randomly generate the snake's head and body position
    headPoint = generateRandomPosition(boardWidth, boardHeight);
    body.add(Point(
        xCoordinate: headPoint.xCoordinate,
        yCoordinate: (headPoint.yCoordinate + 1 == boardHeight) ? 0 : headPoint.yCoordinate + 1));
    body.add(Point(
        xCoordinate: headPoint.xCoordinate,
        yCoordinate: (headPoint.yCoordinate + 1 == boardHeight) ? 0 : headPoint.yCoordinate + 2));
  }

  void move() {
    // Update the snake's body coordinates based on its direction
    // the snake moves by adding the old head as the first point and removing the last point
    body.insert(0, headPoint);
    body.removeLast();
    // Update the snake's head new coordinates
    switch (direction) {
      case 'up':
        {
          headPoint = Point(
              xCoordinate: headPoint.xCoordinate,
              yCoordinate: (headPoint.yCoordinate == 0) ? 22 : headPoint.yCoordinate - 1);
          break;
        }
      case 'down':
        {
          headPoint = Point(
              xCoordinate: headPoint.xCoordinate,
              yCoordinate: (headPoint.yCoordinate == 22) ? 0 : headPoint.yCoordinate + 1);
          break;
        }
      case 'left':
        {
          headPoint = Point(
              xCoordinate: (headPoint.xCoordinate == 0) ? 13 : headPoint.xCoordinate - 1,
              yCoordinate: headPoint.yCoordinate);
          break;
        }
      case 'right':
        {
          headPoint = Point(
              xCoordinate: (headPoint.xCoordinate == 13) ? 0 : headPoint.xCoordinate + 1,
              yCoordinate: headPoint.yCoordinate);
          break;
        }
    }
  }

  changeDirection(String nextDirection) {
    // Change the snake's direction with restrictions
    switch (nextDirection) {
      case 'up':
        {
          if (direction != 'down') {
            direction = nextDirection;
          }
          break;
        }
      case 'down':
        {
          if (direction != 'up') {
            direction = nextDirection;
          }
          break;
        }
      case 'left':
        {
          if (direction != 'right') {
            direction = nextDirection;
          }
          break;
        }
      case 'right':
        {
          if (direction != 'left') {
            direction = nextDirection;
          }
          break;
        }
    }
  }

  void checkCollision() {
    // Check if the snake has collided with itself or the boundaries of the game board
  }
}
