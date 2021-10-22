// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:convert';

import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/services/manager.dart';
import 'package:flash_youtube_downloader/services/offline/managers/shared_prefs_manager.dart';

class SharedPrefHandler extends ManagerHandler<ISharedProps> {
  SharedPrefHandler() {
    setManager(SharedPrefsManager.instance);
  }

  @override
  Manager? setManager(ISharedProps? newManager) {
    return super.setManager(newManager);
  }

  Future<bool> setCountryContent(ContentCountry country) async {
    final value = country.toMap();
    return manager!.setCountryContent(json.encode(value));
  }

  Future<bool> setDownloaderQuality(String value) async {
    return manager!.setCountryContent(value);
  }

  Future<bool> setPlayerQuality(String value) async {
    return manager!.setPlayerQuality(value);
  }

  Future<bool> toggleComments(bool showComments) async {
    return manager!.toggleComments(showComments);
  }

  Future<bool> allowPIP(bool allowPIP) async {
    return manager!.allowPIP(allowPIP);
  }

  Future<bool> setPlayerQualityOnQualityChange(bool playerQuality) async {
    return manager!.setPlayerQualityOnQualityChange(playerQuality);
  }

  bool? get allowPlayerQualityOnQualityChange =>
      manager!.allowPlayerQualityOnQualityChange;

  bool? get allowPIPValue => manager!.allowPIPValue;

  bool? get showComments => manager!.showComments;

  ContentCountry? get contentCountry => manager!.contentCountry;

  String? get downloaderQuality => manager!.downloaderQuality;

  String? get playerQuality => manager!.playerQuality;
}
