import 'package:flutter/material.dart';
import 'package:snake/features/difficulty/presentation/difficulty_view.dart';
import 'package:snake/features/game/presentation/game_view.dart';
import 'package:snake/features/home/presentation/home_view.dart';
import 'package:snake/features/options/presentation/options_view.dart';
import 'package:snake/features/splash/presentation/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Snake',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashView(),
          '/home': (context) => const HomeView(),
          '/difficulty': (context) => const DifficultyView(),
          '/game': (context) => const GameView(),
          '/options': (context) => const OptionsView(),
        });
  }
}
