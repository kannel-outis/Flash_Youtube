// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flash_utils/flash_utils.dart';
import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/services/manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager implements ISharedProps {
  SharedPrefsManager._();
  static final SharedPrefsManager _instance = SharedPrefsManager._();
  static SharedPrefsManager get instance {
    return _instance;
  }

  final DOWNLOADER_QUALITY = "download_quality";
  final PLAYER_QUALITY = "player_qaulity";
  final CONTENT_COUNTRY = "content_country";
  final SHOW_COMMENTS = "show_comments";
  final ALLOW_PIP = "allow_PIP";
  final SET_PLAYER_QUALITY_ON_QUALITY_CHANGE =
      "set_player_quality_on_quality_change";
  final SET_DOWNLOAD_PATH = "set_download_path";
  final CAN_GO_PIP = "can_go_pip";
  final APP_THEME_MODE = "app_theme_mode";

  static late SharedPreferences _prefs;

  Future<SharedPreferences?> getInstance() async {
    // ignore: join_return_with_assignment
    _prefs = await SharedPreferences.getInstance();
    canGoPiP(false);
    return _prefs;
  }

  @override
  Future<bool> setCountryContent(String value) async {
    return _prefs.setString(CONTENT_COUNTRY, value);
  }

  @override
  Future<bool> setDownloaderQuality(String value) async {
    return _prefs.setString(DOWNLOADER_QUALITY, value);
  }

  @override
  Future<bool> setPlayerQuality(String value) async {
    return _prefs.setString(PLAYER_QUALITY, value);
  }

  @override
  ContentCountry? get contentCountry {
    final String? rawString = _prefs.getString(CONTENT_COUNTRY);
    if (rawString == null) return null;
    final Map<String, String> map = (json.decode(rawString) as Map)
        .map((key, value) => MapEntry(key as String, value as String));
    return ContentCountry.fromJson(map);
  }

  @override
  String? get downloaderQuality => _prefs.getString(DOWNLOADER_QUALITY);

  @override
  String? get playerQuality => _prefs.getString(PLAYER_QUALITY);

  @override
  void dispose() {}

  @override
  Future<bool> toggleComments(bool showComments) async {
    return _prefs.setBool(SHOW_COMMENTS, showComments);
  }

  @override
  bool? get showComments => _prefs.getBool(SHOW_COMMENTS);

  @override
  bool? get allowPIPValue => _prefs.getBool(ALLOW_PIP);

  @override
  Future<bool> allowPIP(bool allowPIP) async {
    return _prefs.setBool(ALLOW_PIP, allowPIP);
  }

  @override
  bool? get allowPlayerQualityOnQualityChange =>
      _prefs.getBool(SET_PLAYER_QUALITY_ON_QUALITY_CHANGE);

  @override
  Future<bool> setPlayerQualityOnQualityChange(bool playerQuality) {
    return _prefs.setBool(SET_PLAYER_QUALITY_ON_QUALITY_CHANGE, playerQuality);
  }

  @override
  Future<bool> setDefaultDownloadPath(FilePath path) {
    final pathToString = json.encode(path.toMap());
    return _prefs.setString(
      SET_DOWNLOAD_PATH,
      pathToString,
    );
  }

  @override
  FilePath? get filePath {
    final stringJson = _prefs.getString(SET_DOWNLOAD_PATH);
    if (stringJson == null) return null;
    final decodeJson = (json.decode(stringJson) as Map)
        .map((key, value) => MapEntry(key as String, value));
    return FilePath.fromMap(decodeJson);
  }

  @override
  bool? get canGoPIP => _prefs.getBool(CAN_GO_PIP);

  @override
  Future<bool> canGoPiP(bool canGoPiP) async {
    return _prefs.setBool(CAN_GO_PIP, canGoPiP);
  }

  @override
  Future<bool> setAppTheme(String themeToString) async {
    return _prefs.setString(APP_THEME_MODE, themeToString);
  }

  @override
  // TODO: implement themeModeString
  String? get themeModeString => _prefs.getString(APP_THEME_MODE);
}
