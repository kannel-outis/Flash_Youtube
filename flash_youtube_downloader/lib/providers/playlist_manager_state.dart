// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/playlist/playlist_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'base_state_notifier.dart';

class PlaylistManagerState extends BaseStateNotifier<PlaylistManager> {
  PlaylistManagerState() : super(PlaylistManager(growablePlayList: true));
  static final playlistManagerState =
      StateNotifierProvider<PlaylistManagerState, PlaylistManager>((ref) {
    return PlaylistManagerState();
  });

  void prev() {
    state.setCurrentPlayingVideo(state.prevVideo, false);
  }

  // ignore: use_setters_to_change_properties
  void next(YoutubeVideo video, [bool shouldSaveVideo = true]) {
    state.setCurrentPlayingVideo(video, shouldSaveVideo);
  }

  void changePlaylistManagerInstance(
    bool growablePlaylist, [
    List<YoutubeVideo>? initialPlayList,
  ]) {
    state = PlaylistManager(
      growablePlayList: growablePlaylist,
      initialPlayList: initialPlayList,
    );
  }
}
