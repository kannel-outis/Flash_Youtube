import 'package:flash_youtube_downloader/components/custom_nested_view.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/providers/change_current_playing.dart';
import 'package:flash_youtube_downloader/providers/playlist_manager_state.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HivePlaylistPage extends ConsumerWidget {
  final HivePlaylist playlist;
  const HivePlaylistPage({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final playlistManagerStateNotifier =
        watch(PlaylistManagerState.playlistManagerState.notifier);
    final currentPlaying =
        watch(ChangeCurrentPlaying.changeCurrentPlayingProvider);

    return CustomWillScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0.0,
          title: Text(
            playlist.playlistName,
            style: theme.textTheme.headline5,
          ),
        ),
        body: CustomNestedView(
          videoCount: playlist.videos.length,
          playIconOnpressed: () {
            playlistManagerStateNotifier.changePlaylistManagerInstance(
                false, playlist.videos);
            currentPlaying.changeCurrentVideoplaying(playlist.videos.first);
            playlistManagerStateNotifier.typeState
                .setCurrentPlayingVideo(playlist.videos.first);
          },
          child: ListView.builder(
            itemCount: playlist.videos.length,
            itemBuilder: (context, index) {
              return VideoInfoTile(
                video: playlist.videos.reversed.toList()[index],
                index: index,
                isPlayListInfo: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
