import 'package:flutter/material.dart';
import 'package:snake/core/utils/styles.dart';

class BoardSizeController extends StatelessWidget {
  const BoardSizeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0, top: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: Styles.flatButton,
                    child: const Text('Increase Height'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
                      onPressed: () {},
                      style: Styles.flatButton,
                      child: const Text('Increase Width')),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: Styles.flatButton,
                      child: const Text('Decrease Width')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
