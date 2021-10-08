import 'package:flash_youtube_downloader/services/offline/hive/hive_handler.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_youtube_video.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flutter/foundation.dart';

class PlaylistState extends ChangeNotifier {
  final hiveHandler = HiveHandler();

  Future<void> createPlaylist(
      HiveYoutubeVideo video, String playlistName) async {
    final playlist = HivePlaylist(
      videos: [
        video,
      ],
      playlistName: playlistName,
    );
    await hiveHandler.createPlaylist(playlist);
  }
}
