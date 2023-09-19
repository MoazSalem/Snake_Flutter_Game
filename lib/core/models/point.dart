import 'dart:math';

class Point {
  int xCoordinate;
  int yCoordinate;

  Point({required this.xCoordinate, required this.yCoordinate});
}

Point generateRandomPosition(int boardWidth, int boardHeight) {
  Random random = Random();
  int x = random.nextInt(boardWidth);
  int y = random.nextInt(boardHeight);
  return Point(xCoordinate: x, yCoordinate: y);
}
