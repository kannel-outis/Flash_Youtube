// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flash_utils/flash_utils.dart';
import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/history.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_youtube_video.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/watch_later.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flutter/foundation.dart';

abstract class Manager {
  void dispose() {}

  @override
  String toString() {
    return "$runtimeType";
  }
}

abstract class IHiveManager extends Manager {
  Future<void> saveWatchLaterToDb(HiveWatchLater watchlater);
  List<HiveWatchLater> getAllWatchlater();
  Future<void> saveWatchHistory(HiveWatchHistory watchHistory);
  List<HiveWatchHistory> getAllWatchHistory();

  ///TODO: implemet later
  Future<void> createPlaylist(HivePlaylist hivePlaylist);
  Future<void> addToPlaylistVideos(HiveYoutubeVideo video);
  HivePlaylist getSinglePlaylist(String playlistName);
  List<HivePlaylist> getAllSavedPlaylist();

  //downloads
  Future<void> saveNewDownloadItem(HiveDownloadItem downloadItem);
  List<HiveDownloadItem> getAllDownloadItem();
  Future<void> deleteAllDownloadsFromHistory();
}

abstract class IDownloadManager extends Manager {
  Future<bool> downloadStream();
  Future<void> cancelDownload();
  Future<void> pauseDownload();
  bool get videoDownload;
  bool get audioDownload;
  bool get videoAudioDownload;
  DownloadState get downloadState;
}

abstract class ISharedProps extends Manager {
  Future<bool> setPlayerQuality(String value);
  Future<bool> setDownloaderQuality(String value);
  Future<bool> setCountryContent(String value);
  Future<bool> toggleComments(bool showComments);
  Future<bool> allowPIP(bool allowPIP);
  Future<bool> canGoPiP(bool canGoPiP);
  Future<bool> setPlayerQualityOnQualityChange(bool playerQuality);
  Future<bool> setDefaultDownloadPath(FilePath path);
  Future<bool> setAppTheme(String themeToString);
  Future<bool> setAutoPlay(bool autoPlay);
  bool? get allowPlayerQualityOnQualityChange;
  bool? get showComments;
  bool? get allowPIPValue;
  bool? get canGoPIP;
  bool? get autoPlay;
  FilePath? get filePath;
  ContentCountry? get contentCountry;
  String? get downloaderQuality;
  String? get playerQuality;
  String? get themeModeString;
}

abstract class ManagerHandler<T extends Manager?> {
  T? _manager;

  @protected
  T? get manager => _manager;

  @protected
  @mustCallSuper
  Manager? setManager(T? newManager) {
    return _manager ??= newManager;
  }

  @mustCallSuper
  void dispose() {
    _manager!.dispose();
  }
}
