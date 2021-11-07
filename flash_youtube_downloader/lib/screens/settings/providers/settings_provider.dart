// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flash_youtube_downloader/screens/settings/states/settings_change_notifier.dart';
import 'package:flash_youtube_downloader/screens/settings/states/theme_data_state_.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsProvider {
  static final settingsChangeNotifierProvider =
      ChangeNotifierProvider<SettingsChangeNotifier>(
    (ref) {
      return SettingsChangeNotifier();
    },
  );
  static final themeSettings = StateNotifierProvider<ThemeDataState, ThemeMode>(
    (ref) {
      return ThemeDataState();
    },
  );
}
