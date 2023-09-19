part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameStart extends GameState {}

class GameChangeControl extends GameState {}

class GameNextPosition extends GameState {}

class GameFoodEaten extends GameState {}

class GameOver extends GameState {}

class GameWon extends GameState {}