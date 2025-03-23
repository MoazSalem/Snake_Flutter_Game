class GameBoard {
  late List<List<int>> grid;
  late int width;
  late int height;

  GameBoard({required this.width, required this.height}) {
    grid = List.generate(height, (_) => List.filled(width, 0));
  }
  GameBoard.withGrid({required this.grid}) {
    width = grid[0].length;
    height = grid.length;
  }
  GameBoard copyWith({List<List<int>>? grid}) =>
      GameBoard.withGrid(grid: grid ?? this.grid);
}
