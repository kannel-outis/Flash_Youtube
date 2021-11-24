import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/offline/hive/hive_handler.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/history.dart';
import 'package:flash_youtube_downloader/utils/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentVideoStateProvider extends StateNotifier<YoutubeVideo?> {
  CurrentVideoStateProvider(YoutubeVideo? state) : super(state) {
    _hiveHandler = HiveHandler();
  }

  late final HiveHandler _hiveHandler;

  // ignore: use_setters_to_change_properties
  void setVideoState(YoutubeVideo video) {
    final HiveWatchHistory watchHistory =
        HiveWatchHistory(video: Helper.youtubeVideoHelper(video));
    state = null;
    state = video;
    _hiveHandler.saveWatchHistory(watchHistory);
  }

  void disposeVideoState() {
    state = null;
  }
}
