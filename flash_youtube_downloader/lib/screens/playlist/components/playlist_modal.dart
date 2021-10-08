import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/playlist/components/add_playlist_dialog.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flash_youtube_downloader/utils/helper.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'playlist_modal_tile.dart';

class PlayListModal extends StatelessWidget {
  final YoutubeVideo video;
  const PlayListModal({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 300,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<HivePlaylist>>(
              valueListenable:
                  Hive.box<HivePlaylist>(HiveInit.hivePlaylistBoxName)
                      .listenable(),
              builder: (context, box, child) {
                final playlists = box.values.toList().reversed.toList();
                return Column(
                  children: [
                    if (playlists.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            "Create Playlists",
                            style: theme.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                    for (var item in playlists)
                      PlayListModalTile(
                          leadingIcon: Icons.playlist_add_rounded,
                          onPressed: () async {
                            final video = Helper.youtubeVideoHelper(this.video);
                            item.videos.add(video);
                            await item.save().then(
                                  (value) =>
                                      Utils.navigationKey.currentState!.pop(),
                                );
                          },
                          title: item.playlistName),
                  ],
                );
              },
            ),
          ),
          PlayListModalTile(
            title: "Add PlayList",
            leadingIcon: Icons.add,
            onPressed: () {
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (context) => AddPlaylistDialog(
                  video: video,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
