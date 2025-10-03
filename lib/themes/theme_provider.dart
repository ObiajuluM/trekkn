import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider extends StateNotifier<ThemeMode> {
  ThemeModeProvider() : super(ThemeMode.system);

  

  Future<void> changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);
  }

  setTheme(ThemeMode mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = mode;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);
  }

  toDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = ThemeMode.dark;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);

    // print(" is dark 2: ${prefs.getBool('night')}");
  }

  toLight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = ThemeMode.light;

    // set state in local storage
    state == ThemeMode.light
        ? await prefs.setBool('night', false)
        : await prefs.setBool('night', true);

    // print(" is dark 2: ${prefs.getBool('night')}");
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeProvider, ThemeMode>((ref) {
  return ThemeModeProvider();
});
