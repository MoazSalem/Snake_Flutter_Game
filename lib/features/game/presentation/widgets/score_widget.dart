import 'package:flutter/material.dart';
import 'package:snake/core/utils/service_locator.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Score: '),
        Text(
          '1000',
          style: TextStyle(color: getIt.get<ColorScheme>().primary),
        ),
      ],
    );
  }
}
