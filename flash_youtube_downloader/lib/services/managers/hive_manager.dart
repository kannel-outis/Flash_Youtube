import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_youtube_video.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/watch_later.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/history.dart';
import 'package:hive/hive.dart';

import 'manager.dart';

class HiveManager implements IHiveManager {
  HiveManager._();
  static HiveManager? _instance;
  static HiveManager? get instance {
    return _instance ??= HiveManager._();
  }

  final watchLaterBox =
      Hive.box<HiveWatchLater>(HiveInit.hiveWatchLaterBoxName);
  final playListBox = Hive.box<HivePlaylist>(HiveInit.hivePlaylistBoxName);
  final downloadItemBox =
      Hive.box<HiveDownloadItem>(HiveInit.hiveDownloadItems);

  @override
  List<HivePlaylist> getAllSavedPlaylist() {
    return playListBox.values.toList().reversed.toList();
  }

  @override
  Future<void> createPlaylist(HivePlaylist hivePlaylist,
      {Function(String)? returnMessage}) async {
    final bool playlistHasSameName = playListBox.values
        .where((element) => element.playlistName == hivePlaylist.playlistName)
        .isNotEmpty;

    if (playlistHasSameName) {
      returnMessage?.call(
          "please use another name for this playlist. name already taken");
      return;
    }
    await playListBox.add(hivePlaylist);
  }

  @override
  List<HiveWatchHistory> getAllWatchHistory() {
    // TODO: implement getAllWatchHistory
    throw UnimplementedError();
  }

  @override
  Future<void> saveWatchLaterToDb(HiveWatchLater watchlater) async {
    final bool exists = watchLaterBox.values
        .where((element) => element.video.videoUrl == watchlater.video.videoUrl)
        .isNotEmpty;
    if (exists) return;
    await watchLaterBox.add(watchlater);
  }

  @override
  List<HiveWatchLater> getAllWatchlater() {
    return watchLaterBox.values.toList();
  }

  @override
  HivePlaylist getSinglePlaylist(String playlistName) {
    // TODO: implement getSinglePlaylist
    throw UnimplementedError();
  }

  @override
  Future<void> saveWatchHistory(HiveWatchHistory watchHistory) async {
    // TODO: implement saveWatchHistory
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> addToPlaylistVideos(HiveYoutubeVideo video) async {}

  @override
  List<HiveDownloadItem> getAllDownloadItem() {
    return downloadItemBox.values.toList();
  }

  @override
  Future<void> saveNewDownloadItem(HiveDownloadItem downloadItem) async {
    await downloadItemBox.add(downloadItem);
  }
}
