import 'package:flutter/material.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/core/utils/styles.dart';

class Controller extends StatelessWidget {
  final int style;
  const Controller({super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24.0, right: 24.0, bottom: 24.0, top: 6.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.15,
        child: Row(
          children: [
            Expanded(
              flex: style == 2 ? 1 : 2,
              child: ElevatedButton(
                onPressed: () {},
                style: Styles.flatButton,
                child: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            style == 2
                ? Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: Styles.flatButton.copyWith(
                          backgroundColor: WidgetStateProperty.all<Color>(getIt
                              .get<ColorScheme>()
                              .surface
                              .withValues(alpha: 0.7))),
                      child: const Icon(Icons.arrow_upward),
                    ),
                  )
                : Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: Styles.flatButton.copyWith(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    getIt
                                        .get<ColorScheme>()
                                        .surface
                                        .withValues(alpha: 0.7))),
                            child: const Icon(Icons.arrow_upward),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: Styles.flatButton.copyWith(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    getIt
                                        .get<ColorScheme>()
                                        .surface
                                        .withValues(alpha: 0.4))),
                            child: const Icon(Icons.arrow_downward),
                          ),
                        ),
                      ],
                    ),
                  ),
            style == 2
                ? Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: Styles.flatButton.copyWith(
                          backgroundColor: WidgetStateProperty.all<Color>(getIt
                              .get<ColorScheme>()
                              .surface
                              .withValues(alpha: 0.4))),
                      child: const Icon(Icons.arrow_downward),
                    ),
                  )
                : Container(),
            Expanded(
              flex: style == 2 ? 1 : 2,
              child: ElevatedButton(
                onPressed: () {},
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
