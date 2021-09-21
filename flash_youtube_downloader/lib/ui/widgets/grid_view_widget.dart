import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/ui/screens/home/home_screen.dart';
import 'package:flash_youtube_downloader/ui/widgets/video_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'mini_player/mini_player_draggable.dart';

class GridViewWidget extends ConsumerWidget {
  const GridViewWidget({
    Key? key,
    required this.gridCount,
    required this.data,
    required this.maxWidth,
    required this.heightWithMaxHeight,
    this.physics,
    this.showUploaderPic = true,
    required MiniPlayerController miniPlayerController,
  })  : _miniPlayerController = miniPlayerController,
        super(key: key);

  final int gridCount;
  final List<YoutubeVideo> data;
  final double maxWidth;
  final num heightWithMaxHeight;
  final MiniPlayerController _miniPlayerController;
  final bool showUploaderPic;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return GridView.builder(
      shrinkWrap: true,
      physics: physics,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: 15,
        childAspectRatio: maxWidth / heightWithMaxHeight,
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          child: VideoInfoTile(
            _miniPlayerController,
            showChannelProfilePic: showUploaderPic,
            video: data[index],
            maxWidth: maxWidth,
          ),
        );
      },
    );
  }
}
