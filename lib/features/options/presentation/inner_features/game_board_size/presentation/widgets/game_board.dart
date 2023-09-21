import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/models/game_board.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/view_modal/options_cubit/options_cubit.dart';

class GameBoardWidget extends StatelessWidget {
  final OptionsCubit c;

  const GameBoardWidget({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameBoard gameBoard = GameBoard(width: c.boardWidth, height: c.boardHeight);
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, state) {
        return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            itemCount: c.boardHeight * c.boardWidth,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.all(c.boardHeight / c.boardWidth),
                  child: Container(
                    width: 10,
                    height: 10,
                    color: getIt.get<ColorScheme>().onSecondary.withOpacity(0.6),
                  ));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: c.boardWidth,
            ));
      },
    );
    ;
  }
}
