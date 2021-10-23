import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/channel/providers/channel_providers.dart';
import 'package:flash_youtube_downloader/screens/channel/widgets/channel_tile.dart';
import 'package:flash_youtube_downloader/screens/mini_player/providers/miniplayer_providers.dart';
import 'package:flash_youtube_downloader/screens/playlist/components/playlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'circular_progress_indicator.dart';
import 'video/video_info_tile_.dart';

class CustomPagnationListview extends HookWidget {
  final GrowablePage growablePage;
  const CustomPagnationListview({Key? key, required this.growablePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final channelVideoState =
        useProvider(ChannelProviders.channelVideoProvider(growablePage));
    final channelVideoNotifier = useProvider(
      ChannelProviders.channelVideoProvider(growablePage).notifier,
    );
    final miniController = useProvider(MiniPlayerProviders.miniPlayerC);
    return Scrollbar(
      controller: controller,
      isAlwaysShown: false,
      thickness: 0,
      hoverThickness: 0,
      notificationPredicate: (notification) {
        if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent &&
            !channelVideoState) {
          // channelVideoNotifier.hasReachedEnd = true;
          channelVideoNotifier.fetchNextItems();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: growablePage.growableListItems.length,
        itemBuilder: (context, index) {
          Widget? _child;
          if (growablePage.growableListItems[index] is Channel) {
            final channel = growablePage.growableListItems[index] as Channel;
            _child = ChannelTile(
              channel: channel,
              controller: miniController,
            );
          } else if (growablePage.growableListItems[index] is Playlist) {
            final playlist = growablePage.growableListItems[index] as Playlist;
            _child = PlayListTile(playlist: playlist);
          } else {
            final video = growablePage.growableListItems[index] as YoutubeVideo;
            _child = VideoInfoTile(
              video: video,
              isSearch: growablePage is Search,
              isPlayListInfo: growablePage is PlaylistInfo,
              index: index,
            );
          }

          return Column(
            children: [
              _child,
              if (index == (growablePage.growableListItems.length - 1) &&
                  channelVideoState)
                const SizedBox(
                  child: Center(
                    child: CustomCircularProgressIndicator(),
                  ),
                )
              else if (index == (growablePage.growableListItems.length - 1))
                SizedBox(
                  height: 70,
                  child: channelVideoNotifier.hasReachedLastPage
                      ? const Center(
                          child: Text("You have reached the bottom"),
                        )
                      : const SizedBox(),
                )
              else
                const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
