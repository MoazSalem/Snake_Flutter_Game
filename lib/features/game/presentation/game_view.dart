import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/screen_arguments.dart';
import 'view_modal/game_cubit/game_cubit.dart';
import 'widgets/game_view_body.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return BlocProvider(
      create: (context) => GameCubit()..setDifficulty(difficultyType: args.difficultyType),
      child: const Scaffold(body: Center(child: SafeArea(child: GameViewBody()))),
    );
  }
}
