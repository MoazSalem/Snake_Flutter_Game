import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/firebase_options.dart';

initializeServices() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LeaderboardItem>(LeaderboardItemAdapter());
  await Hive.openBox('optionsBox');
  await Hive.openBox('leaderBoardBox');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
