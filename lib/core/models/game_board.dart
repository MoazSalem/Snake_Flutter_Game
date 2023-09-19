class GameBoard {
  late List<List<int>> grid;
  int width;
  int height;

  GameBoard({required this.width, required this.height}) {
    grid = List.generate(height, (_) => List.filled(width, 0));
  }
}
