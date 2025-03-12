import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/core/utils/styles.dart';
import 'package:snake/features/game/presentation/cubit/game_cubit.dart';

class Controller extends StatelessWidget {
  const Controller({super.key});

  @override
  Widget build(BuildContext context) {
    final int style = Hive.box('optionsBox').get('controllerStyle', defaultValue:  1);
    GameCubit c = getIt.get<GameCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.padding, right: AppSizes.padding, bottom: AppSizes.padding, top: AppSizes.topPadding),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.15,
        child: Row(
          children: [
            Expanded(
              flex: style == 2 ? 1 : 2,
              child: ElevatedButton(
                onPressed: () {
                  c.changeDirection('left');
                },
                style: Styles.flatButton,
                child: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            style == 2
                ? Expanded(
                    child: ElevatedButton(
                      onPressed: () => c.changeDirection('up'),
                      style: Styles.flatButton.copyWith(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              getIt.get<ColorScheme>().background.withOpacity(0.7))),
                      child: const Icon(Icons.arrow_upward),
                    ),
                  )
                : Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => c.changeDirection('up'),
                            style: Styles.flatButton.copyWith(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    getIt.get<ColorScheme>().background.withOpacity(0.7))),
                            child: const Icon(Icons.arrow_upward),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => c.changeDirection('down'),
                            style: Styles.flatButton.copyWith(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    getIt.get<ColorScheme>().background.withOpacity(0.4))),
                            child: const Icon(Icons.arrow_downward),
                          ),
                        ),
                      ],
                    ),
                  ),
            style == 2
                ? Expanded(
                    child: ElevatedButton(
                      onPressed: () => c.changeDirection('down'),
                      style: Styles.flatButton.copyWith(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              getIt.get<ColorScheme>().background.withOpacity(0.4))),
                      child: const Icon(Icons.arrow_downward),
                    ),
                  )
                : Container(),
            Expanded(
              flex: style == 2 ? 1 : 2,
              child: ElevatedButton(
                onPressed: () {
                  c.changeDirection('right');
                },
                style: Styles.flatButton,
                child: const Icon(Icons.arrow_forward_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
