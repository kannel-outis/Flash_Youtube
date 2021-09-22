import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/ui/screens/channel/channel_info.dart';
import 'package:flash_youtube_downloader/ui/screens/home/home_screen.dart';
import 'package:flash_youtube_downloader/ui/widgets/comment_tile.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/grid_view_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/info_icon.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';
import '/utils/extensions.dart';

final commentsprovider =
    FutureProvider.family<Comments?, YoutubeVideoInfo>((ref, videoInfo) {
  return videoInfo.getComments();
});

// ignore: unused_element
class MiniPlayerWidget extends HookWidget {
  // ignore: prefer_const_constructors_in_immutables
  MiniPlayerWidget({Key? key, required MiniPlayerController controller})
      : _miniPlayerController = controller,
        super(key: key);

  late final MiniPlayerController _miniPlayerController;

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 4,
        textDirection: TextDirection.ltr)
      ..layout();
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentVideoState = useProvider(currentVideoStateProvider);
    final controller = useProvider(youtubePlayerController);
    final fullVideoInfo = useProvider(videoStateFullInfo);

    final containerHeight = useState(0.0);
    final isExpanded = useState(false);
    int gridCount = 0;

    final maxWidth = () {
      double screenWidth = 0.0;
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        screenWidth =
            MediaQuery.of(context).size.width - (20 + Utils.blockWidth * 4);
        if (screenWidth < 550) {
          gridCount = 1;
          return screenWidth;
        } else if (screenWidth > 550 && screenWidth < 960) {
          gridCount = 3;

          return screenWidth / 3;
        } else {
          gridCount = 4;
          return screenWidth / 4;
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
      return Utils.blockHeight * 15;
    }();
    return SafeArea(
      child: MiniPlayer(
        miniPlayerController: _miniPlayerController,
        percentage: (per) {
          // print(per);
        },
        playerChild: Material(
          child: YoutubePlayer(
            loadingWidth: 8,
            controller: controller!,
            colors: YoutubePlayerColors.auto(
              barColor: Colors.white.withOpacity(.4),
              bufferedColor: Colors.white.withOpacity(.8),
            ),
          ),
        ),
        child: Material(
          child: (currentVideoState!.videoInfo == null)
              ? SizedBox(
                  child: fullVideoInfo.when(
                    data: (data) {
                      return const SizedBox();
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (o, s) => CustomErrorWidget<YoutubeVideoInfo>(
                      future: videoStateFullInfo,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height:
                            (Utils.blockHeight * 13.5) + containerHeight.value,
                        decoration: const BoxDecoration(
                            // color: Colors.black,
                            ),
                        padding: const EdgeInsets.only(top: 5),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(
                                      currentVideoState.videoInfo!.description);
                                  final textSize = _textSize(
                                      currentVideoState.videoInfo!.description!,
                                      theme.textTheme.subtitle2!);
                                  final countLines =
                                      (textSize.width / (Utils.blockWidth * 50))
                                          .ceil();
                                  final height =
                                      countLines * (textSize.height * 2);
                                  if (!isExpanded.value) {
                                    containerHeight.value += height;
                                    isExpanded.value = true;
                                  } else {
                                    containerHeight.value -= height;
                                    isExpanded.value = false;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  height: Utils.blockHeight * 4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                currentVideoState
                                                    .videoInfo!.videoName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      // fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${currentVideoState.videoInfo!.viewCount.toString().convertToViews(false)} views",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: const [
                                          // Animated
                                          Icon(Icons.expand_more),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///likes, dislikes, share and download / save
                              SizedBox(
                                // color: Colors.pink,
                                height: Utils.blockHeight * 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InfoIcon(
                                      icon: Icons.thumb_up_alt_outlined,
                                      label: currentVideoState
                                          .videoInfo!.likeCount
                                          .toString()
                                          .convertToViews(),
                                    ),
                                    SizedBox(width: Utils.blockWidth * 7),
                                    InfoIcon(
                                      icon: Icons.thumb_down_alt_outlined,
                                      label: currentVideoState
                                          .videoInfo!.dislikeCount
                                          .toString()
                                          .convertToViews(),
                                    ),
                                    SizedBox(width: Utils.blockWidth * 7),
                                    const InfoIcon(
                                      icon: Icons.reply_outlined,
                                      label: "share",
                                    ),
                                    SizedBox(width: Utils.blockWidth * 7),
                                    const InfoIcon(
                                      icon:
                                          Icons.vertical_align_bottom_outlined,
                                      label: "download",
                                    ),
                                    SizedBox(width: Utils.blockWidth * 7),
                                    const InfoIcon(
                                      icon: Icons.library_add_outlined,
                                      label: "save",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: .5, color: Colors.grey),
                                    bottom: BorderSide(
                                        width: .5, color: Colors.grey),
                                  ),
                                  // color: Colors.white,
                                ),
                                height: Utils.blockHeight * 3.5,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _miniPlayerController.closeMiniPlayer();
                                        Utils.navigationKey.currentState!.push(
                                          MaterialPageRoute(
                                            builder: (context) => ChannelInfo(
                                              controller: _miniPlayerController,
                                              youtubeVideo: currentVideoState,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: Utils.blockWidth * 7,
                                        width: Utils.blockWidth * 7,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: FadeInImage(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(
                                                currentVideoState.videoInfo!
                                                    .uploaderAvatarUrl),
                                            placeholder: MemoryImage(
                                                Utils.transparentImage),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentVideoState
                                                  .videoInfo!.uploaderName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Text(
                                              "${currentVideoState.uploaderChannelInfo!.subscriberCount.toString().convertToViews()} subscribers",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                // child: Text(currentVideoState.videoInfo!.description!),
                                child: currentVideoState.videoInfo!.description!
                                        .contains("<")
                                    ? Html(
                                        data: currentVideoState
                                            .videoInfo!.description,
                                        style: {
                                          "*": Style(
                                            fontSize: FontSize(
                                                Utils.blockWidth * 2.6),
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.white,
                                          ),
                                        },
                                      )
                                    : Text(
                                        currentVideoState
                                            .videoInfo!.description!,
                                        style: theme.textTheme.subtitle2),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridViewWidget(
                          gridCount: gridCount,
                          data: currentVideoState.videoInfo!.relatedVideos,
                          maxWidth: maxWidth,
                          heightWithMaxHeight: heightWithMaxHeight,
                          miniPlayerController: _miniPlayerController,
                          showUploaderPic: false,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        child: currentVideoState.videoInfo!.comments == null
                            ? useProvider(commentsprovider(
                                    currentVideoState.videoInfo!))
                                .when(
                                data: (data) => const SizedBox(),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (o, s) => CustomErrorWidget<Comments?>(
                                    future: commentsprovider(
                                        currentVideoState.videoInfo!)),
                              )
                            : Column(
                                children: currentVideoState
                                    .videoInfo!.comments!.comments!
                                    .map(
                                      (e) => CommentTile(
                                        _miniPlayerController,
                                        e: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
