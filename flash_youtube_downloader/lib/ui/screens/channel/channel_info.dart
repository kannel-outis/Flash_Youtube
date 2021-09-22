import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/grid_view_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/ui/widgets/video_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../utils/extensions.dart';
import '../../../utils/utils.dart';

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
    final maxWidth = () {
      double screenWidth = 0.0;
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        screenWidth =
            MediaQuery.of(context).size.width - (20 + Utils.blockWidth * 4);
        if (screenWidth < 550) {
          gridCount = 1;
          return screenWidth;
        } else if (screenWidth > 550 && screenWidth < 960) {
          gridCount = 2;

          return screenWidth / 2;
        } else {
          gridCount = 3;
          return screenWidth / 3;
        }
      }
      screenWidth = MediaQuery.of(context).size.height - 20;
      if (screenWidth < 550) {
        gridCount = 2;
        return screenWidth;
      } else if (screenWidth > 550 && screenWidth < 960) {
        gridCount = 3;
        return screenWidth / 2;
      } else {
        gridCount = 4;
        return screenWidth / 3;
      }
    }();

    final heightWithMaxHeight = () {
      if (MediaQuery.of(context).size.width < 550) {
        return 250;
      } else if (MediaQuery.of(context).size.width > 700) {
        return 400;
      }
      return Utils.blockHeight * 18;
    }();
    final theme = Theme.of(context);
    final channelReader = useProvider(uploaderUrl == null
        ? channelInfoProvider(youtubeVideo!)
        : channelInfoExtractProvider(uploaderUrl!));
    final tabController = useTabController(initialLength: 3);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: channelReader.when(
        data: (data) {
          return FutureBuilder<PaletteGenerator>(
            future: PaletteGenerator.fromImageProvider(
                CachedNetworkImageProvider(data!.bannerUrl == null
                    ? "https://s.ytimg.com/yts/img/channels/c4/default_banner-vflYp0HrA.jpg"
                    : data.bannerUrl!)),
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
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: snapshot.data!.dominantColor!.color,
                      toolbarHeight: 40,
                      title: Text(
                        data.name,
                        style: theme.textTheme.headline5!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      snap: true,
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
                                // child: Text(
                                //   "HOME",
                                //   style: theme.textTheme.bodyText1!.copyWith(
                                //     fontWeight: FontWeight.normal,
                                //     color: Colors.white.withOpacity(.8),
                                //   ),
                                // ),
                              ),
                              Tab(text: "VIDEOS"),
                              Tab(text: "ABOUT"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
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
                                            image: CachedNetworkImageProvider(data
                                                        .bannerUrl ==
                                                    null
                                                ? "https://s.ytimg.com/yts/img/channels/c4/default_banner-vflYp0HrA.jpg"
                                                : data.bannerUrl!),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: Utils.blockHeight * 7,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              // circle size plus left padding
                                              width:
                                                  (Utils.blockWidth * 25) + 30,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.name,
                                                    style: theme
                                                        .textTheme.headline5,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    "${data.subscriberCount.toString().convertToViews(true, false)} subscribers",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                          color: Colors.white
                                                              .withOpacity(.7),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  top: ((Utils.blockHeight * 12) / 2).abs(),
                                  child: Container(
                                    height: Utils.blockWidth * 25,
                                    width: Utils.blockWidth * 25,
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.dominantColor!.color
                                          .withOpacity(.8),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: 5,
                                        color:
                                            snapshot.data!.dominantColor!.color,
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
                          GridViewWidget(
                            showUploaderPic: false,
                            physics: const NeverScrollableScrollPhysics(),
                            gridCount: gridCount,
                            data: data.videoUploads,
                            maxWidth: maxWidth,
                            heightWithMaxHeight: heightWithMaxHeight,
                            miniPlayerController: controller,
                          ),
                        ],
                      ),
                    )
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
          future: uploaderUrl == null
              ? channelInfoProvider(youtubeVideo!)
              : channelInfoExtractProvider(uploaderUrl!),
        ),
      ),
    );
  }
}
