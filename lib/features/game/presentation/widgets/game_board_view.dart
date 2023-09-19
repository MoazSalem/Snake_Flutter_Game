import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/game/presentation/view_modal/game_cubit/game_cubit.dart';
import 'game_point.dart';

class GameBoardView extends StatefulWidget {
  final int width;
  final int height;
  const GameBoardView({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  late GameCubit c;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameCubit>(context).startGame(width: widget.width, height: widget.height);
    getIt.registerSingleton<GameCubit>(GameCubit.get(context));
    c = getIt.get<GameCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    getIt.unregister<GameCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
          )),
    );
  }
}
