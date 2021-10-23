import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/components/circular_progress_indicator.dart';
import 'package:flash_youtube_downloader/components/custom_nested_view.dart';
import 'package:flash_youtube_downloader/components/custom_pagenation_widget.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/playlist_providers.dart';

class PlaylistPage extends ConsumerWidget {
  final Playlist playlist;
  const PlaylistPage({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);

    final playlistInfoFuture =
        watch(PlaylistProviders.playlistFuture(playlist.playListUrl));
    return CustomWillScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0.0,
          title: Text(
            playlist.playListName,
            style: theme.textTheme.headline5,
          ),
        ),
        body: playlistInfoFuture.when(
          data: (data) {
            return CustomNestedView(
              videoCount: playlist.streamCount,
              child: CustomPagnationListview(
                growablePage: data,
              ),
            );
          },
          loading: () => const Center(
            child: CustomCircularProgressIndicator(),
          ),
          error: (obj, stk) => CustomErrorWidget(
            obj: obj,
            autoDisposeFutureProvider:
                PlaylistProviders.playlistFuture(playlist.playListUrl),
          ),
        ),
      ),
    );
  }
}
