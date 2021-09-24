library channel_info;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/grid_view_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/ui/widgets/video/video_info_tile.dart';
import 'package:flash_youtube_downloader/ui/widgets/video/video_info_tile_.dart'
    as v;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../utils/extensions.dart';
import '../../../utils/utils.dart';

part 'home.dart';
part 'video.dart';
part 'about.dart';

final _extract = Provider<Extract>((ref) => Extract());

// ignore: must_be_immutable
class ChannelInfo extends HookWidget {
  final MiniPlayerController controller;
  final YoutubeVideo? youtubeVideo;
  final String? uploaderUrl;
  ChannelInfo({
    Key? key,
    this.uploaderUrl,
    required this.controller,
    this.youtubeVideo,
  }) : super(key: key);
  int gridCount = 0;
  final channelInfoExtractProvider =
      FutureProvider.family<Channel?, String>((ref, uploaderUrl) {
    return ref.read(_extract).getChannelInfo(uploaderUrl);
  });

  @override
  Widget build(BuildContext context) {
    final channelReader = useProvider(uploaderUrl == null
        ? channelInfoProvider(youtubeVideo!)
        : channelInfoExtractProvider(uploaderUrl!));
    final tabController = useTabController(initialLength: 3);
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: channelReader.when(
        data: (data) {
          return FutureBuilder<PaletteGenerator>(
            // TODO: put future.delayed();
            future: PaletteGenerator.fromImageProvider(
                CachedNetworkImageProvider(data!.bannerUrl == null
                    ? "https://s.ytimg.com/yts/img/channels/c4/default_banner-vflYp0HrA.jpg"
                    : data.bannerUrl!.replaceAll("=w1060", "=w650"))),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                // appBar: AppBar(
                //   backgroundColor: snapshot.data!.dominantColor!.color,
                // ),
                body: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, hasSlivers) {
                    return [
                      SliverAppBar(
                        backgroundColor: snapshot.data!.dominantColor!.color,
                        toolbarHeight: 40,
                        title: Text(
                          data.name,
                          style: theme.textTheme.headline5!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        // snap: true,
                        pinned: true,
                        floating: true,
                        bottom: PreferredSize(
                          preferredSize: Size(Utils.blockWidth * 100, 40),
                          child: SizedBox(
                            height: 40.0,
                            child: TabBar(
                              // isScrollable: true,
                              controller: tabController,
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              indicatorWeight: 1,
                              labelStyle: theme.textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.normal,
                              ),
                              tabs: const [
                                Tab(
                                  text: "HOME",
                                ),
                                Tab(text: "VIDEOS"),
                                Tab(text: "ABOUT"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: tabController,
                    children: [
                      _Home(
                          data: data,
                          colorGen: snapshot.data!,
                          controller: controller),
                      _Videos(
                        channel: data,
                      ),
                      _About(),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (o, s) => CustomErrorWidget<Channel?>(
          future: uploaderUrl == null
              ? channelInfoProvider(youtubeVideo!)
              : channelInfoExtractProvider(uploaderUrl!),
        ),
      ),
    );
  }
}
