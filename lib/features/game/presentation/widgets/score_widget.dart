import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/utils/service_locator.dart';
import '../view_modal/game_cubit/game_cubit.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
  builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Score: '),
        Text(
          getIt.get<GameCubit>().score.toString(),
          style: TextStyle(color: getIt.get<ColorScheme>().primary),
        ),
      ],
    );
  },
);
  }
}
