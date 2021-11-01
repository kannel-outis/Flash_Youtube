// ignore_for_file: avoid_positional_boolean_parameters
import 'package:flash_utils/flash_utils.dart';
import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/services/offline/shared_preferences/shared_prefs_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player/youtube_player.dart';

class SettingsChangeNotifier extends ChangeNotifier {
  final _sharedHandler = SharedPrefHandler();

  bool? _showComments;
  bool? _allowPIP;
  bool? _allowSetPlayerQualityOnQualityChange;
  ContentCountry? _contentCountry;
  YoutubePlayerVideoQuality? _playerQuality;
  FilePath? _filePath;
  bool? _canGoPiP;

  void setAllowSetPlayerQualityOnQualityChange(
    bool allowSetPlayerQualityOnQualityChange,
  ) {
    _allowSetPlayerQualityOnQualityChange =
        allowSetPlayerQualityOnQualityChange;
    notifyListeners();
    _sharedHandler
        .setPlayerQualityOnQualityChange(allowSetPlayerQualityOnQualityChange);
  }

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

  void setPlayerQuality(String playerQuality) {
    _playerQuality = playerQuality.stringToQuality;
    notifyListeners();
    _sharedHandler.setPlayerQuality(playerQuality);
  }

  Future<void> setDeafultDownloadPath() async {
    final path = await FlashUtils().selectFolder();
    _filePath = path;
    notifyListeners();
    if (_filePath == null) return;
    _sharedHandler.setDefaultDownloadPath(_filePath!);
  }

  void setCanGoPiP(bool canGoPIP) {
    _canGoPiP = canGoPIP;
    notifyListeners();
    _sharedHandler.canGoPiP(canGoPiP);
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

  YoutubePlayerVideoQuality get playerQuality {
    return _playerQuality ??
        _sharedHandler.playerQuality?.stringToQuality ??
        YoutubePlayerVideoQuality.quality_144p;
  }

  bool get allowSetPlayerQualityOnQualityChange {
    return _allowSetPlayerQualityOnQualityChange ??
        _sharedHandler.allowPlayerQualityOnQualityChange ??
        false;
  }

  FilePath get filePath {
    return _filePath ??
        _sharedHandler.filePath ??
        FilePath(
          path: "/storage/emulated/0/FlashDownloader",
          encodedpath: "/storage/emulated/0/FlashDownloader",
          isAbsolute: true,
          isRelative: false,
        );
  }

  bool get canGoPiP {
    return _canGoPiP ?? _sharedHandler.canGoPIP ?? false;
  }
}
