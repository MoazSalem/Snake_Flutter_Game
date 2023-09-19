import 'package:flutter/material.dart';
import 'package:snake/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: HomeViewBody(),
    );
  }
}
