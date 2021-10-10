import 'package:flash_youtube_downloader/services/offline/hive/models/history.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_youtube_video.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/watch_later.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flutter/foundation.dart';

import 'hive_manager.dart';

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
}

abstract class IDownloadManager extends Manager {
  Future<bool> downloadStream();
  Future<void> cancelDownload();
  bool get videoDownload;
  bool get audioDownload;
  bool get videoAudioDownload;
  // bool get downloadCompleted;
  // bool get downloadCanceled;
  // bool get downloadFailded;
  DownloadState get downloadState;
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

  bool get checkIfChatBoxExistAlready {
    if (_manager is HiveManager) {
      var _hiveManager = _manager as HiveManager;
      // return _hiveManager.checkIfChatBoxExistAlready;
      return true;
    } else {
      return false;
    }
  }
}
