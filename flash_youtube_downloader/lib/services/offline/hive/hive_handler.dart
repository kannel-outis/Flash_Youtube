import 'package:flash_youtube_downloader/services/offline/managers/hive_manager.dart';
import 'package:flash_youtube_downloader/services/offline/managers/manager.dart';

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
}
