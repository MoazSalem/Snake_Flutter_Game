import 'package:flutter/material.dart';

class Styles {
  static final flatButton = ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      )),
      minimumSize: WidgetStateProperty.all<Size>(
          const Size(double.infinity, double.infinity)));
}
