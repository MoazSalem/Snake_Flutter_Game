import 'package:flutter/material.dart';

class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.2,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.2),
                  )),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(1000, 1000))),
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side:
                              BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.2),
                        )),
                        minimumSize: MaterialStateProperty.all<Size>(const Size(1000, 1000))),
                    child: const Icon(Icons.arrow_upward),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side:
                              BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.2),
                        )),
                        minimumSize: MaterialStateProperty.all<Size>(const Size(1000, 1000))),
                    child: const Icon(Icons.arrow_downward),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.2),
                  )),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(1000, 1000))),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
