import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/widgets/video/video_info_tile.dart';
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
    this.show = false,
    this.itemsCount,
    this.showUploaderPic = true,
    required MiniPlayerController miniPlayerController,
  })  : _miniPlayerController = miniPlayerController,
        super(key: key);

  final int gridCount;
  final int? itemsCount;
  final List<YoutubeVideo> data;
  final double maxWidth;
  final num heightWithMaxHeight;
  final MiniPlayerController _miniPlayerController;
  final bool showUploaderPic;
  final ScrollPhysics? physics;
  final bool show;

  int _calculate(int length) {
    if (itemsCount != null) {
      if (itemsCount! > length) {
        return length;
      } else {
        return itemsCount!;
      }
    } else {
      return length;
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (show) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
          crossAxisSpacing: 15,
          childAspectRatio: maxWidth / heightWithMaxHeight,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return SizedBox(
              child: VideoInfoTile(
                _miniPlayerController,
                showChannelProfilePic: showUploaderPic,
                video: data[index],
                maxWidth: maxWidth,
              ),
            );
          },
          childCount: _calculate(data.length),
          addAutomaticKeepAlives: false,
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      cacheExtent: data.length.toDouble() * 3,
      physics: physics,
      itemCount: _calculate(data.length),
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
