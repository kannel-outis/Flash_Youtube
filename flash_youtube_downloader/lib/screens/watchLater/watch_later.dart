import 'package:flash_youtube_downloader/components/custom_nested_view.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/providers/change_current_playing.dart';
import 'package:flash_youtube_downloader/providers/playlist_manager_state.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/watch_later.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WatchLater extends ConsumerWidget {
  const WatchLater({Key? key}) : super(key: key);

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
            "Watch Later",
            style: theme.textTheme.headline5,
          ),
        ),
        body: ValueListenableBuilder<Box<HiveWatchLater>>(
          valueListenable:
              Hive.box<HiveWatchLater>(HiveInit.hiveWatchLaterBoxName)
                  .listenable(),
          builder: (context, box, child) {
            final watchLaterList = box.values.toList().reversed.toList();
            final videosList = watchLaterList.map((e) => e.video).toList();
            return CustomNestedView(
              videoCount: watchLaterList.length,
              playIconOnpressed: () {
                playlistManagerStateNotifier.changePlaylistManagerInstance(
                    false, videosList);
                currentPlaying.changeCurrentVideoplaying(videosList.first);
                playlistManagerStateNotifier.typeState
                    .setCurrentPlayingVideo(videosList.first);
              },
              child: ListView.builder(
                itemCount: watchLaterList.length,
                itemBuilder: (context, index) {
                  return VideoInfoTile(
                    video: watchLaterList[index].video,
                    index: index,
                    isPlayListInfo: true,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
