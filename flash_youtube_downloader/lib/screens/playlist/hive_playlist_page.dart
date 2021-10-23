import 'package:flash_youtube_downloader/components/custom_nested_view.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flutter/material.dart';

class HivePlaylistPage extends StatelessWidget {
  final HivePlaylist playlist;
  const HivePlaylistPage({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
