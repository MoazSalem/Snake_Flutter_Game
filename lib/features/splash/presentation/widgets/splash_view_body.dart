import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snake/core/utils/assets.dart';
import 'package:snake/core/utils/service_locator.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  late ColorScheme colorScheme;
  late Size size;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      getIt.registerSingleton<ColorScheme>(colorScheme);
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      getIt.registerSingleton<Size>(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: colorScheme.background,
          systemNavigationBarColor: colorScheme.background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(AssetsData.snake, height: 100, semanticsLabel: 'snake logo'),
          ],
        ));
  }
}
