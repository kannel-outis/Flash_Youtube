import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';

class YoutubeControllerState extends StateNotifier<YoutubePlayerController?> {
  YoutubeControllerState() : super(null);

  // ignore: avoid_setters_without_getters
  set youtubeControllerState(String link) {
    state = null;
    state = YoutubePlayerController.link(
        youtubeLink: link, quality: YoutubePlayerVideoQuality.quality_144p);
  }
}
