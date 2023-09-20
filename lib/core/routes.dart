import 'package:flutter/material.dart';
import 'package:snake/features/difficulty/presentation/difficulty_view.dart';
import 'package:snake/features/game/presentation/game_view.dart';
import 'package:snake/features/home/presentation/home_view.dart';
import 'package:snake/features/leaderboard/presentation/leaderboard_view.dart';
import 'package:snake/features/options/presentation/inner_features/game_board_size/presentation/game_board_size_view.dart';
import 'package:snake/features/options/presentation/inner_features/game_controller_style/presentation/game_controller_style_view.dart';
import 'package:snake/features/options/presentation/options_view.dart';
import 'package:snake/features/splash/presentation/splash_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashView(),
  '/home': (context) => const HomeView(),
  '/difficulty': (context) => const DifficultyView(),
  '/game': (context) => const GameView(),
  '/leaderboard': (context) => const LeaderboardView(),
  '/options': (context) => const OptionsView(),
  '/GameBoardSize': (context) => const GameBoardSizeView(),
  '/GameControllerStyle': (context) => const GameControllerStyleView(),
};
