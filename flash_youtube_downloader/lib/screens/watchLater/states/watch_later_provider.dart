import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/offline/hive/hive_handler.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/watch_later.dart';
import 'package:flash_youtube_downloader/utils/helper.dart';
import 'package:flutter/widgets.dart';

class WatchLaterChangeNotifier extends ChangeNotifier {
  final hiveHandler = HiveHandler();

  Future<void> saveToWatchlater(YoutubeVideo video) async {
    final hiveYoutubeVideo = Helper.youtubeVideoHelper(video);
    final watchlater = HiveWatchLater(video: hiveYoutubeVideo);
    await hiveHandler.saveWatchLaterToDb(watchlater);
  }
}
