import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';

class GameBoardWidget extends StatelessWidget {
  final OptionsCubit c;

  const GameBoardWidget({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, state) {
        return GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.padding, vertical: AppSizes.smallerPadding),
            itemCount: c.state.boardHeight * c.state.boardWidth,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      EdgeInsets.all(c.state.boardHeight / c.state.boardWidth),
                  child: Container(
                    width: 10,
                    height: 10,
                    color: getIt
                        .get<ColorScheme>()
                        .onSecondary
                        .withValues(alpha: 0.6),
                  ));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: c.state.boardWidth,
            ));
      },
    );
  }
}
