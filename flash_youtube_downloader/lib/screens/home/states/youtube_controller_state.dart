import 'package:flash_youtube_downloader/services/offline/shared_preferences/shared_prefs_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';

class YoutubeControllerState extends StateNotifier<YoutubePlayerController?> {
  YoutubeControllerState() : super(null);

  // ignore: avoid_setters_without_getters
  set youtubeControllerState(String link) {
    final playerQuality = SharedPrefHandler().playerQuality?.stringToQuality;
    state = null;
    state = YoutubePlayerController.link(
      youtubeLink: link,
      quality: playerQuality ?? YoutubePlayerVideoQuality.quality_144p,
    );
  }
}
