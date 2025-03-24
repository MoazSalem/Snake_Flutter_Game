import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/models/leaderboard_item.dart';
import 'package:snake/core/utils/constants.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  // Private variables for internal state management
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box _leaderboardBox = Hive.box('leaderBoardBox');
  bool _isLoading = false;

  LeaderboardCubit()
      : super(LeaderboardState(
          leaderboard: {},
          isLoading: false,
          lastUpdated: null,
          leaderboardTimestamps: {},
          currentDifficulty: GameValues.difficultyNames[0],
        )) {
    // Initialize state with cached data from Hive
    _loadCachedData();
  }

  static LeaderboardCubit get(context) => BlocProvider.of(context);

  // Load initial data from Hive cache
  void _loadCachedData() {
    final Map<String, List<LeaderboardItem>> cachedLeaderboard = {};
    final Map<String, Timestamp> cachedTimestamps = {};

    for (var difficulty in GameValues.difficultyNames) {
      // Get the list with proper cast
      final dynamic rawList = _leaderboardBox.get('${difficulty}List', defaultValue: <LeaderboardItem>[]);
      List<LeaderboardItem> difficultyList = [];

      if (rawList is List) {
        // Cast each item to LeaderboardItem
        difficultyList = List<LeaderboardItem>.from(
            rawList.whereType<LeaderboardItem>()
        );
      }

      cachedLeaderboard[difficulty] = difficultyList;

      // Load timestamp for each difficulty level
      final cachedTimestamp = _leaderboardBox.get('${difficulty}Timestamp');
      if (cachedTimestamp != null) {
        cachedTimestamps[difficulty] = Timestamp.fromMillisecondsSinceEpoch(
            cachedTimestamp is int
                ? cachedTimestamp
                : cachedTimestamp.millisecondsSinceEpoch);
      }
    }

    emit(state.copyWith(
      leaderboard: cachedLeaderboard,
      isLoading: false,
      lastUpdated: _leaderboardBox.get('lastUpdated'),
      leaderboardTimestamps: cachedTimestamps,
    ));
  }

  // Main method to ensure leaderboard data is up-to-date
  Future<void> refreshLeaderboard({bool forceRefresh = false}) async {
    if (_isLoading && !forceRefresh) {
      return;
    }

    _isLoading = true;
    emit(state.copyWith(isLoading: true));

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      final bool hasInternet =
          connectivityResult.first != ConnectivityResult.none;

      if (hasInternet) {
        // Upload any pending scores first
        await _uploadPendingScores();

        // Check if we need to refresh by comparing timestamps
        await _checkAndRefreshLeaderboards(forceRefresh);
      } else {
        debugPrint('No internet connection. Using cached data.');
      }
    } catch (e) {
      debugPrint('Error refreshing leaderboard: $e');
    } finally {
      _isLoading = false;
      final now = DateTime.now();
      _leaderboardBox.put('lastUpdated', now);

      emit(state.copyWith(
        isLoading: false,
        lastUpdated: now,
      ));
    }
  }

  // Check if we need to refresh each leaderboard by comparing timestamps
  Future<void> _checkAndRefreshLeaderboards(bool forceRefresh) async {
    for (var difficulty in GameValues.difficultyNames) {
      bool needsRefresh = forceRefresh;

      if (!needsRefresh) {
        try {
          // Get the latest timestamp from Firebase
          final timestampDoc = await _firestore
              .collection("metadata")
              .doc("leaderboard_timestamps")
              .get();

          if (timestampDoc.exists) {
            final serverTimestamp =
                timestampDoc.data()?[difficulty] as Timestamp?;
            final localTimestamp = state.leaderboardTimestamps[difficulty];

            // If server timestamp is newer or we don't have a local timestamp, refresh
            if (serverTimestamp != null &&
                (localTimestamp == null ||
                    serverTimestamp.compareTo(localTimestamp) > 0)) {
              needsRefresh = true;
            }
          } else {
            // If no timestamp document exists, create it
            await _updateTimestampInFirebase(difficulty);
            needsRefresh = true;
          }
        } catch (e) {
          debugPrint('Error checking timestamp for $difficulty: $e');
          // If there's an error checking the timestamp, refresh just to be safe
          needsRefresh = true;
        }
      }

      if (needsRefresh) {
        await _fetchLeaderboardForDifficulty(difficulty);
      }
    }
  }

  // Upload scores that weren't uploaded during offline play
  Future<void> _uploadPendingScores() async {
    for (var difficulty in GameValues.difficultyNames) {
      final List<LeaderboardItem> difficultyList = _leaderboardBox
          .get('${difficulty}List', defaultValue: <LeaderboardItem>[]);

      final List<LeaderboardItem> updatedList = [];
      bool anyUploaded = false;

      for (var item in difficultyList) {
        if (item.uploaded == 0) {
          final updatedItem = await _uploadToFirebase(item: item);
          updatedList.add(updatedItem);
          if (updatedItem.uploaded == 1) {
            anyUploaded = true;
          }
        } else {
          updatedList.add(item);
        }
      }

      // Update local cache
      _leaderboardBox.put('${difficulty}List', updatedList);

      // Update state
      final updatedLeaderboard =
          Map<String, List<LeaderboardItem>>.from(state.leaderboard);
      updatedLeaderboard[difficulty] = updatedList;
      emit(state.copyWith(leaderboard: updatedLeaderboard));

      // Update timestamp in Firebase if we uploaded any scores
      if (anyUploaded) {
        await _updateTimestampInFirebase(difficulty);
      }
    }
  }

  // Update the timestamp in Firebase to indicate the leaderboard was updated
  Future<void> _updateTimestampInFirebase(String difficulty) async {
    try {
      final now = Timestamp.now();
      await _firestore
          .collection("metadata")
          .doc("leaderboard_timestamps")
          .set({difficulty: now}, SetOptions(merge: true));

      // Update local timestamp
      final updatedTimestamps =
          Map<String, Timestamp>.from(state.leaderboardTimestamps);
      updatedTimestamps[difficulty] = now;

      // Save to Hive
      _leaderboardBox.put('${difficulty}Timestamp', now.millisecondsSinceEpoch);

      emit(state.copyWith(leaderboardTimestamps: updatedTimestamps));
    } catch (e) {
      debugPrint('Error updating timestamp for $difficulty: $e');
    }
  }

  // Fetch leaderboard for a specific difficulty
  Future<void> _fetchLeaderboardForDifficulty(String difficulty) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("${difficulty}List")
          .orderBy("score", descending: true)
          .limit(100)
          .get();

      final List<LeaderboardItem> fetchedList = snapshot.docs
          .map((doc) => LeaderboardItem(
                name: doc['name'],
                difficulty: doc['difficulty'],
                score: doc['score'],
                width: doc['width'],
                height: doc['height'],
                uploaded: 1,
              ))
          .toList();

      // Get latest timestamp
      final timestampDoc = await _firestore
          .collection("metadata")
          .doc("leaderboard_timestamps")
          .get();

      Timestamp? timestamp;
      if (timestampDoc.exists) {
        timestamp = timestampDoc.data()?[difficulty] as Timestamp?;
      }

      if (timestamp == null) {
        timestamp = Timestamp.now();
        await _updateTimestampInFirebase(difficulty);
      }

      // Update local cache
      _leaderboardBox.put('${difficulty}List', fetchedList);
      _leaderboardBox.put(
          '${difficulty}Timestamp', timestamp.millisecondsSinceEpoch);

      // Update state
      final updatedLeaderboard =
          Map<String, List<LeaderboardItem>>.from(state.leaderboard);
      updatedLeaderboard[difficulty] = fetchedList;

      final updatedTimestamps =
          Map<String, Timestamp>.from(state.leaderboardTimestamps);
      updatedTimestamps[difficulty] = timestamp;

      emit(state.copyWith(
        leaderboard: updatedLeaderboard,
        leaderboardTimestamps: updatedTimestamps,
      ));
    } catch (e) {
      debugPrint('Error fetching $difficulty leaderboard: $e');
    }
  }

  // Change current difficulty
  void setDifficulty(String difficulty) {
    if (GameValues.difficultyNames.contains(difficulty)) {
      emit(state.copyWith(currentDifficulty: difficulty));
    }
  }

  // Get leaderboard for current difficulty
  List<LeaderboardItem> getCurrentLeaderboard() {
    return state.leaderboard[state.currentDifficulty] ?? [];
  }

  // Add new score to the leaderboard
  Future<void> addScore({required LeaderboardItem newItem}) async {
    // First, add to local state
    final String difficulty = newItem.difficulty;
    final List<LeaderboardItem> currentList =
        List<LeaderboardItem>.from(state.leaderboard[difficulty] ?? []);

    // Find the correct position to insert
    int insertIndex =
        currentList.indexWhere((item) => item.score < newItem.score);
    if (insertIndex == -1) {
      insertIndex = currentList.length;
    }

    // Insert at the correct position
    currentList.insert(insertIndex, newItem);

    // Limit to 100 items
    if (currentList.length > 100) {
      currentList.removeLast();
    }

    // Update state
    final updatedLeaderboard =
        Map<String, List<LeaderboardItem>>.from(state.leaderboard);
    updatedLeaderboard[difficulty] = currentList;
    emit(state.copyWith(leaderboard: updatedLeaderboard));

    // Update Hive cache
    _leaderboardBox.put('${difficulty}List', currentList);

    // Try to upload to Firebase if online
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.first != ConnectivityResult.none) {
      final updatedItem = await _uploadToFirebase(item: newItem);

      // Update the uploaded status in local state
      if (updatedItem.uploaded == 1) {
        final updatedList = currentList
            .map((item) => item == newItem ? updatedItem : item)
            .toList();

        updatedLeaderboard[difficulty] = updatedList;
        emit(state.copyWith(leaderboard: updatedLeaderboard));

        // Update Hive cache
        _leaderboardBox.put('${difficulty}List', updatedList);

        // Update timestamp in Firebase
        await _updateTimestampInFirebase(difficulty);
      }
    }
  }

  // Upload score to Firebase
  Future<LeaderboardItem> _uploadToFirebase(
      {required LeaderboardItem item}) async {
    try {
      await _firestore.collection("${item.difficulty}List").add({
        'name': item.name,
        'difficulty': item.difficulty,
        'score': item.score,
        'width': item.width,
        'height': item.height,
      });

      return item.copyWith(uploaded: 1);
    } catch (e) {
      debugPrint('Error uploading score to Firebase: $e');
      return item.copyWith(uploaded: 0);
    }
  }
}
