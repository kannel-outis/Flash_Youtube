import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/history.dart';
import 'models/hive_youtube_video.dart';
import 'models/playlist.dart';
import 'models/watch_later.dart';

// ignore: avoid_classes_with_only_static_members
class HiveInit {
  static String hiveWatchLaterBoxName = "watchlater";
  static String hiveWatchHistoryBoxName = "history";
  static String hiveYoutubeVideoBoxName = "youtubevideo";
  static String hivePlaylistBoxName = "playlist";
  static Future<void> init() async {
    final documentDir = await getApplicationDocumentsDirectory();
    Hive.init(documentDir.path);

    Hive.registerAdapter(HivePlaylistAdapter());
    Hive.registerAdapter(HiveWatchLaterAdapter());
    Hive.registerAdapter(HiveYoutubeVideoAdapter());
    Hive.registerAdapter(HiveWatchHistoryAdapter());

    Hive.openBox<HiveWatchHistory>(hiveWatchHistoryBoxName);
    Hive.openBox<HiveWatchLater>(hiveWatchLaterBoxName);
    Hive.openBox<HivePlaylist>(hivePlaylistBoxName);
    Hive.openBox<HiveYoutubeVideo>(hiveYoutubeVideoBoxName);
  }
}
