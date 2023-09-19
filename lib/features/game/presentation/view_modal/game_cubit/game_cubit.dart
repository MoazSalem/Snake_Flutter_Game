import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:snake/core/models/food.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/models/point.dart';
import 'package:snake/core/models/snake.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  static GameCubit get(context) => BlocProvider.of(context);

  late GameBoard gameBoard;
  late Snake snake;
  late Food food;
  late bool game;

  Future<void> startGame({required int width, required int height}) async {
    // create game board, snake and food
    gameBoard = GameBoard(width: width, height: height);
    snake = Snake(boardHeight: gameBoard.height, boardWidth: gameBoard.width);
    food = Food(boardWidth: gameBoard.width, boardHeight: gameBoard.height);
    // put snake head and body on the board
    draw();
    // start the game loop
    game = true;
    emit(GameNextPosition());
    // This is the game loop that runs until the game is over
    while (game == true) {
      snake.move();
      draw();
      emit(GameNextPosition());
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void draw() {
    // put snake head and body on the board
    for (var element in gameBoard.grid) {
      element.fillRange(0, element.length, 0);
    }
    // draw snake head on the board
    gameBoard.grid[snake.headPoint.yCoordinate][snake.headPoint.xCoordinate] = 3;
    // draw snake body on the board
    for (Point point in snake.body) {
      gameBoard.grid[point.yCoordinate][point.xCoordinate] = 2;
    }
    gameBoard.grid[snake.body[0].yCoordinate][snake.body[0].xCoordinate] = 2;
    // draw food on the board
    gameBoard.grid[food.position.yCoordinate][food.position.xCoordinate] = 1;
    emit(GameNextPosition());
  }

  void changeControl() {
    emit(GameChangeControl());
  }
}
