import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/service_locator.dart';
import '../view_modal/game_cubit/game_cubit.dart';
import 'game_point.dart';

class GameBoardView extends StatefulWidget {
  const GameBoardView({super.key});

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  late GameCubit c;
  int width = Hive.box('optionsBox')
      .get('boardWidth', defaultValue: (getIt.get<Size>().width * 0.036).toInt());
  int height = Hive.box('optionsBox')
      .get('boardHeight', defaultValue: ((getIt.get<Size>().width * 0.036) * 1.7).toInt());

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameCubit>(context).startGame(width: width, height: height);
    getIt.registerSingleton<GameCubit>(GameCubit.get(context));
    c = getIt.get<GameCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    c.game = false;
    getIt.unregister<GameCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding, vertical: AppSizes.smallerPadding),
            itemCount: c.gameBoard.width * c.gameBoard.height,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.all(c.gameBoard.height / c.gameBoard.width),
                  child: GamePoint(gameBoard: c.gameBoard, index: index));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: c.gameBoard.width,
            ));
      },
    );
  }
}
