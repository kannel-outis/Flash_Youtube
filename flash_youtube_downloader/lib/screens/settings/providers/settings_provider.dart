// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/screens/settings/states/content_country_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsProvider {
  static final contentCountryState =
      StateNotifierProvider<ContentCountryState, ContentCountry?>((ref) {
    return ContentCountryState();
  });
}
