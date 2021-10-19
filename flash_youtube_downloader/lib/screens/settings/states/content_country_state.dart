import 'dart:convert';

import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/services/offline/shared_preferences/shared_prefs_handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentCountryState extends StateNotifier<ContentCountry?> {
  ContentCountryState() : super(null) {
    final contentCountry = _sharedHandler.contentCountry;
    setState(
      contentCountry ??
          const ContentCountry(countryName: "United States", countryCode: "US"),
    );
  }

  final _sharedHandler = SharedPrefHandler();

  void setState(ContentCountry contentCountry) {
    state = contentCountry;
    _sharedHandler.setCountryContent(contentCountry);
  }
}
