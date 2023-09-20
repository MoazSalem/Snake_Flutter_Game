import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/game/presentation/view_modal/game_cubit/game_cubit.dart';
import 'game_point.dart';

class GameBoardView extends StatefulWidget {
  const GameBoardView({Key? key}) : super(key: key);

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  late GameCubit c;
  int width =
      getIt.get<Box>().get('boardWidth', defaultValue: (getIt.get<Size>().width * 0.036).toInt());
  int height = getIt
      .get<Box>()
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
