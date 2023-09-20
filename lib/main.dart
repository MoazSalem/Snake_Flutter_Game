import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snake/core/routes.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/options/presentation/view_modal/options_cubit/options_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  getIt.registerSingleton<Box>(await Hive.openBox('optionsBox'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OptionsCubit()..getSettings(),
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
