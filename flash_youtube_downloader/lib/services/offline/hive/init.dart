import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/history.dart';
import 'models/hive_youtube_video.dart';
import 'models/playlist.dart';
import 'models/stream_types/stream_quality_adapter.dart';
import 'models/stream_types/streams_type_adapter.dart';
import 'models/watch_later.dart';

// ignore: avoid_classes_with_only_static_members
class HiveInit {
  static String hiveWatchLaterBoxName = "watchlater";
  static String hiveWatchHistoryBoxName = "history";
  static String hiveYoutubeVideoBoxName = "youtubevideo";
  static String hivePlaylistBoxName = "playlist";
  static String hiveDownloadItems = "downloadItems";
  static Future<void> init() async {
    final documentDir = await getApplicationDocumentsDirectory();
    Hive.init(documentDir.path);

    Hive.registerAdapter<HivePlaylist>(HivePlaylistAdapter());
    Hive.registerAdapter<HiveWatchLater>(HiveWatchLaterAdapter());
    Hive.registerAdapter<HiveYoutubeVideo>(HiveYoutubeVideoAdapter());
    Hive.registerAdapter<HiveWatchHistory>(HiveWatchHistoryAdapter());
    Hive.registerAdapter<DownloadState>(DownloadStateAdapter());
    Hive.registerAdapter<HiveDownloadItem>(HiveDownloadItemAdapter());

    // streams adapter
    Hive.registerAdapter<AudioOnlyStream>(AudioOnlyStreamAdapter());
    Hive.registerAdapter<VideoOnlyStream>(VideoOnlyStreamsAdapter());
    Hive.registerAdapter<VideoAudioStream>(VideoAudioStreamsAdapter());
    Hive.registerAdapter<Quality>(QualityAdapter());

    Hive.openBox<HiveWatchHistory>(hiveWatchHistoryBoxName);
    Hive.openBox<HiveWatchLater>(hiveWatchLaterBoxName);
    Hive.openBox<HivePlaylist>(hivePlaylistBoxName);
    Hive.openBox<HiveYoutubeVideo>(hiveYoutubeVideoBoxName);
    Hive.openBox<HiveDownloadItem>(hiveDownloadItems);
  }
}
