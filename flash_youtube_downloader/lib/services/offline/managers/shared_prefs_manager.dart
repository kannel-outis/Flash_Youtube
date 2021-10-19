// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

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

  static late SharedPreferences _prefs;

  Future<SharedPreferences?> getInstance() async {
    // ignore: join_return_with_assignment
    _prefs = await SharedPreferences.getInstance();
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
}
