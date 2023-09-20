import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
              height: 80,
              child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/difficulty'),
                  child: const Text('Start Game'))),
          const SizedBox(height: 16),
          SizedBox(
              height: 60,
              child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/options'),
                  child: const Text('Options'))),
        ],
      ),
    );
  }
}
