import 'package:flutter/material.dart';
import 'package:snake/core/models/food.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/models/snake.dart';
import 'game_point.dart';

class GameBoardView extends StatefulWidget {
  const GameBoardView({Key? key}) : super(key: key);

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  @override
  Widget build(BuildContext context) {
    int width = (MediaQuery.of(context).size.width * 0.036).toInt();
    int height = (width * 1.65).toInt();
    // create game board, snake and food
    GameBoard gameBoard = GameBoard(width: width, height: height);
    Snake snake = Snake(boardHeight: gameBoard.height, boardWidth: gameBoard.width);
    Food food = Food(boardWidth: gameBoard.width, boardHeight: gameBoard.height);
    // put snake head and body on the board
    gameBoard.grid[snake.headPoint.yCoordinate][snake.headPoint.xCoordinate] = 3;
    gameBoard.grid[snake.body[0].yCoordinate][snake.body[0].xCoordinate] = 2;
    // put food on the board
    gameBoard.grid[food.position.yCoordinate][food.position.xCoordinate] = 1;
    return Center(
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          itemCount: gameBoard.width * gameBoard.height,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(gameBoard.height / gameBoard.width),
                child: GamePoint(gameBoard: gameBoard, index: index));
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gameBoard.width,
          )),
    );
  }
}
