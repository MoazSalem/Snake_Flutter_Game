import 'package:flutter/material.dart';

class Controller extends StatelessWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12.0),
      child: SizedBox(
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
                    )),
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, double.infinity))),
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
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(27, 37, 35, 1.0)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, double.infinity))),
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
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(27, 37, 35, 0.8)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, double.infinity))),
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
                    )),
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, double.infinity))),
                child: const Icon(Icons.arrow_forward_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
