import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:snake/core/models/food.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/models/point.dart';
import 'package:snake/core/models/snake.dart';
import 'package:snake/core/utils/assets.dart';
import 'package:snake/core/utils/constants.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(GameState(
          gameBoard: GameBoard(width: 10, height: 10),
          snake: Snake(boardWidth: 10, boardHeight: 10),
          food: Food(boardWidth: 10, boardHeight: 10),
          specialFood: null,
          game: false,
          score: 0,
          difficultyIndex: 0,
          difficultyDuration: Duration(seconds: 0),
          counter: 0,
          highScore: false,
          currentDirection: 'up',
          upcomingDirection: 'up',
        ));
  static GameCubit get(context) => BlocProvider.of(context);
  final Map<String, AudioPlayer> _audioPlayers = {};
  late Timer _gameLoopTimer;

  @override
  Future<void> close() async {
    _gameLoopTimer.cancel();
    for (final player in _audioPlayers.values) {
      await player.dispose();
    }
    return super.close();
  }

  setDifficulty({required int difficultyType}) {
    emit(state.copyWith(
        difficultyIndex: difficultyType,
        difficultyDuration: Duration(
            milliseconds: GameValues.difficultySpeeds[difficultyType])));
  }

  Future<void> startGame({required int width, required int height}) async {
    // create game board, snake and food
    emit(state.copyWith(
      gameBoard: GameBoard(width: width, height: height),
      snake: Snake(boardHeight: height, boardWidth: width),
      food: Food(boardHeight: height, boardWidth: width),
      score: 0,
      counter: GameValues.specialCounter + (10 * state.difficultyIndex),
      game: true,
    ));
    // put snake head and body on the board
    draw();
    // The Game Timer, The delay determines the games speed
    _gameLoopTimer =
        Timer.periodic(state.difficultyDuration, (_) => gameLoop());
  }

  Future<void> gameLoop() async {
    // Stop the timer when the game is over
    if (state.game == false) {
      _gameLoopTimer.cancel();
      return;
    }
    // check if the special food counter is over
    checkCounter();
    // Something fun happens when you reach the high score
    checkHighScore();
    // check if the snake ate the golden apple
    isGoldenEaten();
    // move the snake
    state.snake
        .move(direction: state.currentDirection, gameBoard: state.gameBoard);
    // check if the snake ate the food
    state.food.checkEaten(state.snake.headPoint)
        ? {foodEaten(), emit(state)}
        : null;
    // check if the snake hit itself
    state.snake.checkCollision(gameBoard: state.gameBoard) ? {endGame()} : null;
    draw();
    if (state.currentDirection != state.upcomingDirection) {
      emit(state.copyWith(currentDirection: state.upcomingDirection));
    }
  }

  void endGame() {
    emit(state.copyWith(game: false));
  }

  void draw() {
    // Create a new grid filled with zeros
    List<List<int>> newGrid = List.generate(
      state.gameBoard.height,
      (_) => List.filled(state.gameBoard.width, 0),
    );

    // draw snake head with 3 value, snake body has 2 value, food is 1, golden apples are 4
    if (state.specialFood != null) {
      newGrid[state.specialFood!.position.yCoordinate]
          [state.specialFood!.position.xCoordinate] = 4;
    }

    newGrid[state.food.position.yCoordinate][state.food.position.xCoordinate] =
        1;
    newGrid[state.snake.headPoint.yCoordinate]
        [state.snake.headPoint.xCoordinate] = 3;

    for (Point point in state.snake.body) {
      newGrid[point.yCoordinate][point.xCoordinate] = 2;
    }

    // Update the game board with the new grid
    emit(state.copyWith(gameBoard: state.gameBoard.copyWith(grid: newGrid)));
  }

  Future<void> foodEaten() async {
    // increase snake length
    state.snake.insertPoint(point: state.snake.body.last);
    // play eat food sound
    playAudio(audio: AssetsData.eatAudio);
    // generate new food point
    generateFood();
    // increase the score
    emit(state.copyWith(
      score: state.score + (4 + state.difficultyIndex * 4),
    ));
  }

  void specialFoodEaten() {
    emit(state.copyWith(counter: 0));
    // increase snake length
    state.snake.insertPoint(point: state.snake.body.last);
    // play eat food sound
    playAudio(audio: AssetsData.goldenEatAudio);
    // increase the score
    emit(state.copyWith(
        score: state.score + (state.counter + state.difficultyIndex * 8),
        counter: GameValues.specialCounter + (10 * state.difficultyIndex),
        specialFood: null));
  }

  checkCounter() {
// decrease counter
    switch (state.counter) {
      case const (GameValues.specialCounter ~/ 3):
        {
          playAudio(audio: AssetsData.goldenAppearAudio);
          generateSpecialFood();
          break;
        }
      case 0:
        {
          playAudio(audio: AssetsData.goldenDisappearAudio);
          emit(state.copyWith(
            specialFood: null,
            counter: GameValues.specialCounter + (10 * state.difficultyIndex),
          ));
          break;
        }
    }
    emit(state.copyWith(counter: state.counter - 1));
  }

  checkHighScore() {
    state.highScore
        ? null
        : state.score > GameValues.highScore
            ? {
                emit(state.copyWith(highScore: true)),
                playAudio(audio: AssetsData.easterEggAudio)
              }
            : null;
  }

  isGoldenEaten() {
    state.specialFood != null
        ? state.specialFood!.checkEaten(state.snake.headPoint)
            ? {specialFoodEaten(), emit(state)}
            : null
        : null;
  }

  generateFood() {
    // generate new food
    Food tempFood = Food(
        boardWidth: state.gameBoard.width, boardHeight: state.gameBoard.height);
    switch (state.gameBoard.grid[tempFood.position.yCoordinate]
        [tempFood.position.xCoordinate]) {
      case 0:
        {
          emit(state.copyWith(food: tempFood));
          break;
        }
      default:
        {
          generateFood();
          break;
        }
    }
  }

  generateSpecialFood() {
    // generate new food
    Food tempFood = Food(
        boardWidth: state.gameBoard.width, boardHeight: state.gameBoard.height);
    switch (state.gameBoard.grid[tempFood.position.yCoordinate]
        [tempFood.position.xCoordinate]) {
      case 0:
        {
          emit(state.copyWith(specialFood: tempFood));
          break;
        }
      default:
        {
          generateSpecialFood();
          break;
        }
    }
  }

  playAudio({required String audio}) {
    // create an audio player for each audio
    if (!_audioPlayers.containsKey(audio)) {
      _audioPlayers[audio] = AudioPlayer(handleAudioSessionActivation: false);
      _audioPlayers[audio]!.setAsset(audio, preload: true);
    }
    _audioPlayers[audio]!.seek(Duration.zero);
    _audioPlayers[audio]!.play();
  }

  void changeDirection(String nextDirection) {
    // Change the snake's direction with restrictions
    switch (nextDirection) {
      case 'up':
        {
          if (state.currentDirection != 'down') {
            emit(state.copyWith(upcomingDirection: nextDirection));
          }
          break;
        }
      case 'down':
        {
          if (state.currentDirection != 'up') {
            emit(state.copyWith(upcomingDirection: nextDirection));
          }
          break;
        }
      case 'left':
        {
          if (state.currentDirection != 'right') {
            emit(state.copyWith(upcomingDirection: nextDirection));
          }
          break;
        }
      case 'right':
        {
          if (state.currentDirection != 'left') {
            emit(state.copyWith(upcomingDirection: nextDirection));
          }
          break;
        }
    }
  }
}
