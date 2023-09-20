import 'package:flutter/material.dart';
import 'controller.dart';

class GameControllerStyleViewBody extends StatefulWidget {
  const GameControllerStyleViewBody({Key? key}) : super(key: key);

  @override
  State<GameControllerStyleViewBody> createState() => _GameControllerStyleViewBodyState();
}

class _GameControllerStyleViewBodyState extends State<GameControllerStyleViewBody> {
  late int _style;

  @override
  void initState() {
    super.initState();
    _style = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _style = 1;
            });
          },
          child: Column(
            children: [
              ListTile(
                title: const Text("Style 1"),
                trailing: Radio(value: _style, groupValue: 1, onChanged: (value) {}),
              ),
              const Controller(style: 1),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _style = 2;
            });
          },
          child: Column(
            children: [
              ListTile(
                title: const Text("Style 2"),
                trailing: Radio(value: _style, groupValue: 2, onChanged: (value) {}),
              ),
              const Controller(style: 2),
            ],
          ),
        ),
      ],
    );
  }
}
