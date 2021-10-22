// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/services/offline/hive/hive_handler.dart';
import 'package:flash_youtube_downloader/services/offline/shared_preferences/shared_prefs_handler.dart';
import 'package:flutter/widgets.dart';

class SettingsChangeNotifier extends ChangeNotifier {
  final _sharedHandler = SharedPrefHandler();

  bool? _showComments;
  bool? _allowPIP;
  ContentCountry? _contentCountry;

  void setShowComment(bool showC) {
    _showComments = showC;
    notifyListeners();
    _sharedHandler.toggleComments(showC);
  }

  void setCountentCountry(ContentCountry contentCountry) {
    _contentCountry = contentCountry;
    notifyListeners();
    _sharedHandler.setCountryContent(contentCountry);
  }

  void setAllowPIP(bool allowPIP) {
    _allowPIP = allowPIP;
    notifyListeners();
    _sharedHandler.allowPIP(allowPIP);
  }

  ContentCountry get contentCountry {
    return _contentCountry ??
        _sharedHandler.contentCountry ??
        const ContentCountry(countryName: "United States", countryCode: "US");
  }

  bool get showComments {
    return _showComments ?? _sharedHandler.showComments ?? true;
  }

  bool get allowPIP {
    return _allowPIP ?? _sharedHandler.allowPIPValue ?? true;
  }
}
