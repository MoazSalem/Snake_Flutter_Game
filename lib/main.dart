import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/routes.dart';
import 'package:snake/features/options/presentation/cubit/options_cubit.dart';
import 'package:snake/features/leaderboard/presentation/view_modal/leaderboard_cubit/leaderboard_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<LeaderboardItem>(LeaderboardItemAdapter());
  await Hive.openBox('optionsBox');
  await Hive.openBox('leaderBoardBox');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          create: (context) => LeaderboardCubit()..leaderboardSetup(),
        ),
      ],
      child: MaterialApp(
          title: 'Snake',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: routes),
    );
  }
}
