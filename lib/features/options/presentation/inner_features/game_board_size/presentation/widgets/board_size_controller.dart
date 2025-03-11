import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/core/utils/styles.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';

class BoardSizeController extends StatelessWidget {
  final OptionsCubit c;
  const BoardSizeController({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => c.changeHeight(1),
                      style: Styles.flatButton,
                      child: const Text(AppLocalization.increaseHeight),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => c.changeHeight(0),
                      style: Styles.flatButton,
                      child: const Text(AppLocalization.decreaseHeight),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => c.changeWidth(1),
                        style: Styles.flatButton,
                        child: const Text(AppLocalization.increaseWidth)),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => c.changeWidth(0),
                        style: Styles.flatButton,
                        child: const Text(AppLocalization.decreaseWidth)),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => c.resetSize(),
                        style: Styles.flatButton,
                        child: const Text(AppLocalization.reDefault)),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => {
                              c.saveSize(),
                              Navigator.pop(context),
                            },
                        style: Styles.flatButton,
                        child: const Text(AppLocalization.save)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
