import 'package:flutter/material.dart';
import 'package:snake/features/difficulty/presentation/widgets/difficulty_view_body.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Difficulty'), centerTitle: true, toolbarHeight: 70),
      body: const DifficultyViewBody(),
    );
  }
}
