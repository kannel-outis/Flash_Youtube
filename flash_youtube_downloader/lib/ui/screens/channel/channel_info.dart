import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/ui/widgets/video_info_tile.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:math' as math;

class ChannelInfo extends ConsumerWidget {
  final MiniPlayerController controller;
  final YoutubeVideo youtubeVideo;
  const ChannelInfo(
      {Key? key, required this.controller, required this.youtubeVideo})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final channelReader = watch(channelInfoProvider(youtubeVideo));
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: channelReader.when(
        data: (data) {
          return FutureBuilder<PaletteGenerator>(
            future: PaletteGenerator.fromImageProvider(
                CachedNetworkImageProvider(data!.bannerUrl!)),
            builder: (context, snapshot) {
              print(data.avatarUrl);
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: snapshot.data!.dominantColor!.color,
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: Utils.blockHeight * 21,
                      child: Stack(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  height: Utils.blockHeight * 12,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          data.bannerUrl!),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: Utils.blockHeight * 9,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: ((Utils.blockHeight * 12) / 2).abs(),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: snapshot.data!.dominantColor!.color
                                    .withOpacity(.8),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 5,
                                  color: snapshot.data!.dominantColor!.color,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      data.hdAvatarUrl),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(snapshot.data!.vibrantColor.toString()),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (o, s) => CustomErrorWidget<Channel?>(
          future: channelInfoProvider(youtubeVideo),
        ),
      ),
    );
  }
}
