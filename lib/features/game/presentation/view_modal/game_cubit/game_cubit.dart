import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:snake/core/models/food.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/models/snake.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  static GameCubit get(context) => BlocProvider.of(context);

  late GameBoard gameBoard;
  late Snake snake;

  void startGame({required int width, required int height}) {
    // create game board, snake and food
    gameBoard = GameBoard(width: width, height: height);
    snake = Snake(boardHeight: gameBoard.height, boardWidth: gameBoard.width);
    Food food = Food(boardWidth: gameBoard.width, boardHeight: gameBoard.height);
    // put snake head and body on the board
    gameBoard.grid[snake.headPoint.yCoordinate][snake.headPoint.xCoordinate] = 3;
    gameBoard.grid[snake.body[0].yCoordinate][snake.body[0].xCoordinate] = 2;
    // put food on the board
    gameBoard.grid[food.position.yCoordinate][food.position.xCoordinate] = 1;
    emit(GameNextPosition());
  }

  void changeControl() {
    emit(GameChangeControl());
  }
}
