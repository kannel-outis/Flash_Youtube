import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/playlist/components/playlist_modal.dart';
import 'package:flash_youtube_downloader/screens/watchLater/provider/watch_later_provider.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../modal_sheet.dart';

class CustomPopMenu extends ConsumerWidget {
  final YoutubeVideo video;
  const CustomPopMenu({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final hiveOps = watch(WatchLaterProvider.hiveOpsProvider);
    return SizedBox(
      height: 20,
      width: 20,
      child: PopupMenuButton<MenuType>(
        padding: EdgeInsets.zero,
        iconSize: 20,
        onSelected: (v) {
          switch (v) {
            case MenuType.download:
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ModalSheet(
                    video: video,
                  );
                },
              );
              break;
            case MenuType.watchlater:
              hiveOps.saveToWatchlater(video);
              break;
            case MenuType.playlist:
              showModalBottomSheet(
                context: context,
                builder: (context) => PlayListModal(video: video),
              );
              break;
            default:
          }
        },
        // elevation: 20,
        offset: const Offset(50, 40),
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<MenuType>(
              value: MenuType.watchlater,
              child: Text("Add to Watch Later"),
            ),
            const PopupMenuItem<MenuType>(
              value: MenuType.download,
              child: Text("Download"),
            ),
            const PopupMenuItem<MenuType>(
              value: MenuType.playlist,
              child: Text("Add to Playlist"),
            ),
          ];
        },
      ),
    );
  }
}
