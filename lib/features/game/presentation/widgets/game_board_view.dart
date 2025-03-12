import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/game/presentation/cubit/game_cubit.dart';
import 'game_point.dart';

class GameBoardView extends StatefulWidget {
  const GameBoardView({super.key});

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  late GameCubit c;
  int width = Hive.box('optionsBox').get('boardWidth',
      defaultValue: (getIt.get<Size>().width * 0.036).toInt());
  int height = Hive.box('optionsBox').get('boardHeight',
      defaultValue: ((getIt.get<Size>().width * 0.036) * 1.7).toInt());

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
    c.endGame();
    getIt.unregister<GameCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.padding, vertical: AppSizes.smallerPadding),
        itemCount: c.state.gameBoard.width * c.state.gameBoard.height,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(
                  c.state.gameBoard.width / c.state.gameBoard.height),
              child: GamePoint(gameBoard: c.state.gameBoard, index: index));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: c.state.gameBoard.width,
        ));
  }
}
