import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/features/constants.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial());
  static LeaderboardCubit get(context) => BlocProvider.of(context);

  leaderboardSetup() async {
    // check if there is internet connection
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      debugPrint('No Internet');
    } else {
      // get scores from firebase if there is internet connection
      await uploadNotUploadedScores();
      // get scores from firebase after uploading any scores that were not uploaded
      getFirebaseLeaderBoard();
    }
  }

  // This function uploads any scores that were not uploaded to firebase during offline play
  uploadNotUploadedScores() async {
    for (var difficulty in kDifficultyNames) {
      Hive.box('leaderBoardBox').get("${difficulty}List") != null
          ? Hive.box('leaderBoardBox').get("${difficulty}List").forEach((element) async {
              if (element.uploaded == 0) {
                await uploadToFirebaseLeaderBoard(item: element);
              }
            })
          : Null;
    }
  }

  // This function updates the scores from firebase and saves them to the local database
  getFirebaseLeaderBoard() {
    for (var difficulty in kDifficultyNames) {
      FirebaseFirestore.instance
          .collection("${difficulty}List")
          .orderBy("score", descending: true)
          .get()
          .then((value) {
        List<LeaderboardItem> list = [];
        for (var element in value.docs) {
          list.length <= 100
              ? list.add(LeaderboardItem(
                  name: element['name'],
                  difficulty: element['difficulty'],
                  score: element['score'],
                  width: element['width'],
                  height: element['height'],
                  uploaded: 1))
              : Null;
        }
        Hive.box('leaderBoardBox').put('${difficulty}List', list);
      });
    }
  }

  // Add the score to the offline leaderboard
  Future<void> addToLeaderboard({required LeaderboardItem newItem}) async {
    // check if there is internet connection and upload the score to firebase if there is
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      newItem = await uploadToFirebaseLeaderBoard(item: newItem);
    }
    late List list;
    // get the correct leaderboard for the difficulty
    list = Hive.box('leaderBoardBox')
        .get('${newItem.difficulty}List', defaultValue: <LeaderboardItem>[])!;
    // add the new item to the leaderboard
    int index = list.indexWhere((item) => item.score < newItem.score);
    // If the new item has the lowest score, add it at the end.
    if (index == -1) {
      list.add(newItem);
    } else {
      // Insert the new item at the correct position to maintain the order.
      list.insert(index, newItem);
    }
    // If the leaderboard has more than 100 items, remove the last item.
    if (list.length > 100) {
      list.removeLast();
    }
    // add the score to the leaderboard
    Hive.box('leaderBoardBox').put('${newItem.difficulty}List', list);
  }

  Future<LeaderboardItem> uploadToFirebaseLeaderBoard({required LeaderboardItem item}) async {
    try {
      await FirebaseFirestore.instance.collection("${item.difficulty}List").add({
        'name': item.name,
        'difficulty': item.difficulty,
        'score': item.score,
        'width': item.width,
        'height': item.height,
      });
      item.uploaded = 1;
    } catch (e) {
      item.uploaded = 0;
      debugPrint(e.toString());
    }
    return item;
  }
}
