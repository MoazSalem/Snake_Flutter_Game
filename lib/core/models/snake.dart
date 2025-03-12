import 'package:snake/core/models/game_board.dart';

import 'point.dart';

class Snake {
  List<Point> body = [];
  late Point headPoint;

  Snake({required int boardWidth, required int boardHeight}) {
    // randomly generate the snake's head and body position
    headPoint = generateRandomPosition(boardWidth, boardHeight);
    body.add(Point(
        xCoordinate: headPoint.xCoordinate,
        yCoordinate: (headPoint.yCoordinate + 1 == boardHeight)
            ? 0
            : headPoint.yCoordinate + 1));
  }

  void insertPoint({required Point point}) {
    body.add(point);
  }

  void move({required String direction, required GameBoard gameBoard}) {
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
              yCoordinate: (headPoint.yCoordinate == 0)
                  ? gameBoard.height - 1
                  : headPoint.yCoordinate - 1);
          break;
        }
      case 'down':
        {
          headPoint = Point(
              xCoordinate: headPoint.xCoordinate,
              yCoordinate: (headPoint.yCoordinate == gameBoard.height - 1)
                  ? 0
                  : headPoint.yCoordinate + 1);
          break;
        }
      case 'left':
        {
          headPoint = Point(
              xCoordinate: (headPoint.xCoordinate == 0)
                  ? gameBoard.width - 1
                  : headPoint.xCoordinate - 1,
              yCoordinate: headPoint.yCoordinate);
          break;
        }
      case 'right':
        {
          headPoint = Point(
              xCoordinate: (headPoint.xCoordinate == gameBoard.width - 1)
                  ? 0
                  : headPoint.xCoordinate + 1,
              yCoordinate: headPoint.yCoordinate);
          break;
        }
    }
  }

  bool checkCollision({required GameBoard gameBoard}) {
    // Check if the snake has collided with itself or the boundaries of the game board
    return gameBoard.grid[headPoint.yCoordinate][headPoint.xCoordinate] == 2;
  }
}
