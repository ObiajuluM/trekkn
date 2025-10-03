import 'dart:developer';

import 'package:riverpod/riverpod.dart';
import 'package:health/health.dart';
import 'package:walkit/modules/api/backend.dart';
import 'package:walkit/modules/model/models.dart';

Future<TrekknUser> getUser() async {
  try {
    final response = await ApiClient().dio.get("users/me/");
    // log(response.data.toString());
    return TrekknUser.fromJson(response.data);
  } catch (e) {
    // Log error and return a default user
    log("Error fetching user: $e");
    return TrekknUser();
  }
}

// Example: Fetch profile
Future<TrekknUser?> patchUser(Map<String, dynamic> data) async {
  try {
    final response = await ApiClient().dio.patch("/users/me/", data: data);
    return TrekknUser.fromJson(response.data);
  } catch (e) {
    // Log error and return a default user
    log("Error fetching user: $e");
    return null;
  }
}

Future<List<TrekknUser>?> getLevelLeaderboard() async {
  try {
    final response =
        await ApiClient().dio.get("/users/", queryParameters: {"level": true});
    final List<dynamic> data = response.data; // access "users" array
    return data.map((json) => TrekknUser.fromJson(json)).toList();
  } catch (e) {
    // Log error and return a default user
    log("Error fetching user: $e");
    return null;
  }
}

/// timeframe can be "day", "week", "month", "year"
Future<List<LeaderboardEntry>?> getStepLeaderboard([String timeframe = "day"]) async {
  try {
    final response = await ApiClient()
        .dio
        .get("/users/", queryParameters: {"leaderboard": timeframe});
    final List<dynamic> data = response.data; // access "users" array
    return data.map((json) => LeaderboardEntry.fromJson(json)).toList();
  } catch (e) {
    // Log error and return a default user
    log("Error fetching user: $e");
    return null;
  }
}

class TrekknUserProvider extends StateNotifier<TrekknUser> {
  TrekknUserProvider() : super(TrekknUser()) {
    setUser();
  }

  Future<void> setUser() async {
    state = await getUser();
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    state = await patchUser(data) ?? state;
  }
}

final trekknUserProvider =
    StateNotifierProvider<TrekknUserProvider, TrekknUser>((ref) {
  return TrekknUserProvider();
});
