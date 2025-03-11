import 'package:flutter/material.dart';
import 'package:snake/features/difficulty/presentation/difficulty_view.dart';
import 'package:snake/features/game/presentation/game_view.dart';
import 'package:snake/features/home/presentation/home_view.dart';
import 'package:snake/features/leaderboard/presentation/leaderboard_view.dart';
import 'package:snake/features/options/presentation/inner_features/game_board_size/presentation/game_board_size_view.dart';
import 'package:snake/features/options/presentation/inner_features/game_controller_style/presentation/game_controller_style_view.dart';
import 'package:snake/features/options/presentation/options_view.dart';
import 'package:snake/features/splash/presentation/splash_view.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String difficultyScreen = '/difficulty';
  static const String gameScreen = '/game';
  static const String leaderScreen = '/leaderboard';
  static const String optionsScreen = '/options';
  static const String gameBoardSizeScreen = '/GameBoardSize';
  static const String gameControllerStyleScreen = '/GameControllerStyle';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => const SplashView(),
    homeScreen: (context) => const HomeView(),
    difficultyScreen: (context) => const DifficultyView(),
    gameScreen: (context) => const GameView(),
    leaderScreen: (context) => const LeaderboardView(),
    optionsScreen: (context) => const OptionsView(),
    gameBoardSizeScreen: (context) => const GameBoardSizeView(),
    gameControllerStyleScreen: (context) => const GameControllerStyleView(),
  };
}
