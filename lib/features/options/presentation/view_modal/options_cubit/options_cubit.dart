import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/service_locator.dart';
import 'package:snake/features/constants.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit() : super(OptionsInitial());
  static OptionsCubit get(context) => BlocProvider.of(context);

  late int controllerStyle;
  late int boardWidth;
  late int boardHeight;

  getSettings() {
    controllerStyle = Hive.box('optionsBox').get('controllerStyle') ?? 1;
    boardWidth =
        Hive.box('optionsBox').get('boardWidth') ?? (getIt.get<Size>().width * 0.036).toInt();
    boardHeight = Hive.box('optionsBox').get('boardHeight') ??
        ((getIt.get<Size>().width * 0.036) * 1.7).toInt();
    leaderboardSetup();
  }

  resetSize() {
    boardWidth = (getIt.get<Size>().width * 0.036).toInt();
    boardHeight = ((getIt.get<Size>().width * 0.036) * 1.7).toInt();
    emit(OptionsChanged());
  }

  saveSize() {
    Hive.box('optionsBox').put('boardHeight', boardHeight);
    Hive.box('optionsBox').put('boardWidth', boardWidth);
    emit(OptionsChanged());
  }

  changeControllerStyle(int style) {
    controllerStyle = style;
    Hive.box('optionsBox').put('controllerStyle', controllerStyle);
    emit(OptionsChanged());
  }

  changeHeight(int type) {
    if (type == 1) {
      boardHeight = boardHeight + 1;
    } else {
      boardHeight = boardHeight - 1;
    }
    emit(OptionsChanged());
  }

  changeWidth(int type) {
    if (type == 1) {
      boardWidth = boardWidth + 1;
    } else {
      boardWidth = boardWidth - 1;
    }
    emit(OptionsChanged());
  }

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
          list.add(LeaderboardItem(
              name: element['name'],
              difficulty: element['difficulty'],
              score: element['score'],
              width: element['width'],
              height: element['height'],
              uploaded: 1));
        }
        Hive.box('leaderBoardBox').put('${difficulty}List', list);
      });
    }
  }

  // this function uploads a score to firebase
  uploadToFirebaseLeaderBoard({required LeaderboardItem item}) async {
    await FirebaseFirestore.instance.collection('EasyList').add({
      'name': item.name,
      'score': item.score,
      'difficulty': item.difficulty,
      'width': item.width,
      'height': item.height,
      'uploaded': item.uploaded,
    });
  }
}
