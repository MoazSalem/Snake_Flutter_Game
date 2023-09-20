import 'package:flutter/material.dart';
import 'widgets/options_view_body.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Options'), centerTitle: true, toolbarHeight: 70),
      body: const OptionsViewBody(),
    );
  }
}
