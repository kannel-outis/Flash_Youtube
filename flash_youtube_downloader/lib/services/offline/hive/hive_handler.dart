import 'package:flash_youtube_downloader/services/managers/hive_manager.dart';
import 'package:flash_youtube_downloader/services/managers/manager.dart';

import 'models/hive_download_item.dart';
import 'models/playlist.dart';
import 'models/watch_later.dart';

class HiveHandler extends ManagerHandler<IHiveManager> {
  HiveHandler() {
    setManager(HiveManager.instance);
  }

  @override
  Manager? setManager(IHiveManager? newManager) {
    return super.setManager(newManager);
  }

  Future<void> saveWatchLaterToDb(HiveWatchLater watchlater) async {
    await manager!.saveWatchLaterToDb(watchlater);
  }

  Future<void> createPlaylist(HivePlaylist hivePlaylist,
      {Function(String)? returnMessage}) async {
    await manager!.createPlaylist(hivePlaylist);
  }

  Future<void> saveNewDownloadItem(HiveDownloadItem downloadItem) async {
    await manager!.saveNewDownloadItem(downloadItem);
  }

  List<HiveDownloadItem> get hiveDownloadItems {
    return manager!.getAllDownloadItem();
  }

  Future<void> deleteAllDownloadsFromHistory() async {
    await manager!.deleteAllDownloadsFromHistory();
  }
}
