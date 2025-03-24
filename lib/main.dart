import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/core/utils/localization.dart';
import 'package:snake/core/utils/theme.dart';
import 'package:snake/core/utils/routes.dart';
import 'package:snake/core/utils/initialization_service.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';

import 'features/leaderboard/presentation/cubit/leaderboard_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OptionsCubit>(
          create: (context) => OptionsCubit()..getSettings(),
        ),
        BlocProvider<LeaderboardCubit>(
          create: (context) => LeaderboardCubit()..refreshLeaderboard(),
        ),
      ],
      child: MaterialApp(
          title: AppLocalization.appTitle,
          debugShowCheckedModeBanner: false,
          theme: mainTheme,
          initialRoute: AppRoutes.splashScreen,
          routes: AppRoutes.routes),
    );
  }
}
