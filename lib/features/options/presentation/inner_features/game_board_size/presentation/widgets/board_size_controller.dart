import 'package:flutter/material.dart';
import 'package:snake/core/utils/styles.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';

class BoardSizeController extends StatelessWidget {
  final OptionsCubit c;
  const BoardSizeController({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                      child: const Text('Increase Height'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => c.changeHeight(0),
                      style: Styles.flatButton,
                      child: const Text('Decrease Height'),
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
                        child: const Text('Increase Width')),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => c.changeWidth(0),
                        style: Styles.flatButton,
                        child: const Text('Decrease Width')),
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
                        child: const Text('Reset to Default')),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => {
                              c.saveSize(),
                              Navigator.pop(context),
                            },
                        style: Styles.flatButton,
                        child: const Text('Save')),
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
