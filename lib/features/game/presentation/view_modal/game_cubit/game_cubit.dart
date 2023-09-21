import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/models/food.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/models/point.dart';
import 'package:snake/core/models/snake.dart';
import 'package:snake/core/utils/assets.dart';
import 'package:snake/features/constants.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  static GameCubit get(context) => BlocProvider.of(context);

  late GameBoard gameBoard;
  late Snake snake;
  late Food food;
  late bool game;
  late int score;
  late int difficultyIndex;
  late Duration difficultyDuration;
  String currentDirection = 'up';
  String upcomingDirection = 'up';

  setDifficulty({required int difficultyType}) {
    difficultyIndex = difficultyType;
    difficultyDuration = Duration(milliseconds: kGameDifficultySpeeds[difficultyType]);
  }

  Future<void> startGame({required int width, required int height}) async {
    // create game board, snake and food
    gameBoard = GameBoard(width: width, height: height);
    snake = Snake(boardHeight: gameBoard.height, boardWidth: gameBoard.width);
    food = Food(boardWidth: gameBoard.width, boardHeight: gameBoard.height);
    score = 0;
    // put snake head and body on the board
    draw();
    // start the game loop
    game = true;
    emit(GameStart());
    // This is the game loop that runs until the game is over
    while (game == true) {
      snake.move(direction: currentDirection, gameBoard: gameBoard);
      food.checkEaten(snake.headPoint) ? {foodEaten(), emit(GameFoodEaten())} : null;
      snake.checkCollision(gameBoard: gameBoard) ? {game = false, emit(GameOver())} : null;
      draw();
      emit(GameNextPosition());
      // This delay determines the games speed
      await Future.delayed(difficultyDuration);
      currentDirection != upcomingDirection ? currentDirection = upcomingDirection : null;
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
    // draw food on the board
    gameBoard.grid[food.position.yCoordinate][food.position.xCoordinate] = 1;
    emit(GameNextPosition());
  }

  void foodEaten() {
    // play eat food sound
    AudioPlayer().play(AssetSource(AssetsData.eatAudio));
    // not sure if this is necessary
    AudioPlayer().dispose();
    // add a new point to the snake's body
    snake.body.add(snake.body.last);
    // generate a new food
    generateFood();
    // increase the score
    score += (4 + difficultyIndex * 4);
  }

  generateFood() {
    // generate new food
    Food tempFood = Food(boardWidth: gameBoard.width, boardHeight: gameBoard.height);
    switch (gameBoard.grid[tempFood.position.yCoordinate][tempFood.position.xCoordinate]) {
      case 0:
        {
          food = tempFood;
          break;
        }
      case 2:
        {
          generateFood();
          break;
        }
      case 3:
        {
          generateFood();
          break;
        }
    }
  }

  void changeDirection(String nextDirection) {
    // Change the snake's direction with restrictions
    switch (nextDirection) {
      case 'up':
        {
          if (currentDirection != 'down') {
            upcomingDirection = nextDirection;
          }
          break;
        }
      case 'down':
        {
          if (currentDirection != 'up') {
            upcomingDirection = nextDirection;
          }
          break;
        }
      case 'left':
        {
          if (currentDirection != 'right') {
            upcomingDirection = nextDirection;
          }
          break;
        }
      case 'right':
        {
          if (currentDirection != 'left') {
            upcomingDirection = nextDirection;
          }
          break;
        }
    }
    emit(GameChangeControl());
  }

  // Add the score to the offline leaderboard
  Future<void> addToLeaderboard({required LeaderboardItem newItem}) async {
    // check if there is internet connection and upload the score to firebase if there is
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      newItem = await uploadToFirebaseLeaderBoard(item: newItem);
    }
    late List list;
    // get the correct leaderboard for the difficulty
    list = Hive.box('leaderBoardBox')
        .get('${newItem.difficulty}List', defaultValue: <LeaderboardItem>[])!;
    // add the new item to the leaderboard
    int index = list.indexWhere((item) => item.score < newItem.score);
    // If the new item has the lowest score, add it at the end.
    if (index == -1) {
      list.add(newItem);
    } else {
      // Insert the new item at the correct position to maintain the order.
      list.insert(index, newItem);
    }
    // If the leaderboard has more than 100 items, remove the last item.
    if (list.length > 100) {
      list.removeLast();
    }
    // add the score to the leaderboard
    Hive.box('leaderBoardBox').put('${newItem.difficulty}List', list);
  }

  Future<LeaderboardItem> uploadToFirebaseLeaderBoard({required LeaderboardItem item}) async {
    try {
      await FirebaseFirestore.instance.collection("${item.difficulty}List").add({
        'name': item.name,
        'difficulty': item.difficulty,
        'score': item.score,
        'width': item.width,
        'height': item.height,
      });
      item.uploaded = 1;
    } catch (e) {
      item.uploaded = 0;
      debugPrint(e.toString());
    }
    return item;
  }
}
