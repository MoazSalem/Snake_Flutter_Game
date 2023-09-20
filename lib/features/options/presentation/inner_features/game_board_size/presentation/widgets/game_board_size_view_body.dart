import 'package:flutter/material.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/view_modal/options_cubit/options_cubit.dart';
import 'board_size_controller.dart';
import 'game_board.dart';

class GameBoardSizeViewBody extends StatefulWidget {
  const GameBoardSizeViewBody({Key? key}) : super(key: key);

  @override
  State<GameBoardSizeViewBody> createState() => _GameBoardSizeViewBodyState();
}

class _GameBoardSizeViewBodyState extends State<GameBoardSizeViewBody> {
  late OptionsCubit c;
  @override
  void initState() {
    super.initState();
    c = getIt.get<OptionsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(height: double.infinity, child: GameBoardWidget(c: c)),
          BoardSizeController(c: c),
        ],
      ),
    );
  }
}
