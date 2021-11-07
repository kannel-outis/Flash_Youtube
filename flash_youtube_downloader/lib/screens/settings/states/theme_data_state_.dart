import 'package:flash_youtube_downloader/services/offline/shared_preferences/shared_prefs_handler.dart';
import 'package:flash_youtube_downloader/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeDataState extends StateNotifier<ThemeMode> {
  ThemeDataState() : super(ThemeMode.light) {
    state = sharedHandler.themeModeString?.themify ?? ThemeMode.light;
  }

  final sharedHandler = SharedPrefHandler();

  Future<void> setAppTheme(ThemeMode themeMode) async {
    state = themeMode;
    await Future.delayed(const Duration(seconds: 1), () {
      sharedHandler.setAppTheme(themeMode.stringify);
    });
  }
}
