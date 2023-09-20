import 'package:flutter/material.dart';

class Styles {
  static final flatButton = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      )),
      minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, double.infinity)));
}
