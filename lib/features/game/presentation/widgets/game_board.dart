import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    int hNum = (MediaQuery.of(context).size.width * 0.036).toInt();
    int vNum = (hNum * 1.65).toInt();
    return Center(
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          itemCount: hNum * vNum,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(vNum / hNum),
              child: Container(
                width: 10,
                height: 10,
                color: const Color(0xff1b2523),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: hNum,
          )),
    );
  }
}
