import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/ui/screens/channel/channel_info.dart';
import 'package:flash_youtube_downloader/ui/screens/home/home_screen.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/extensions.dart';

final channelInfoProvider =
    FutureProvider.family<ChannelInfo?, YoutubeVideo>((ref, video) {
  return AsyncMemoizer<ChannelInfo?>()
      .runOnce(() => video.getUploaderChannelInfo());
});

class VideoInfoTile extends ConsumerWidget {
  final YoutubeVideo video;
  final double maxWidth;
  final bool showChannelProfilePic;
  final MiniPlayerController _miniPlayerController;
  const VideoInfoTile(
    this._miniPlayerController, {
    Key? key,
    required this.video,
    required this.maxWidth,
    this.showChannelProfilePic = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader reader) {
    final channelFuture = reader(channelInfoProvider(video));
    final currentVideoStateNotifier =
        reader(currentVideoStateProvider.notifier);
    final youtubePlayerControllerNotifier =
        reader(youtubePlayerController.notifier);
    final currentVideoState = reader(currentVideoStateProvider);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (currentVideoState == null ||
                  video.url != currentVideoState.url) {
                currentVideoStateNotifier.setVideoState(video);
                youtubePlayerControllerNotifier.youtubeControllerState =
                    video.url;
              }
              if (_miniPlayerController.isClosed) {
                Future.delayed(const Duration(milliseconds: 20), () {
                  _miniPlayerController.openMiniPlayer();
                });
              }
              // print(youtubePlayerControllerNotifier.state!.isDisposed);
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                // .replaceAll("hqdefault", "maxresdefault")
                // .toString()
                children: [
                  _FadeInImageWidget(
                    // url: video.hqdefault,
                    url: video.mqdefault,
                    altImageUrl: video.thumbnailUrl,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Container(
                      color: Colors.black.withOpacity(.7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Center(
                        child: Text(
                          Utils.trimTime(video.duration.toString()),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!showChannelProfilePic)
                  const SizedBox()
                else
                  GestureDetector(
                    onTap: () {
                      Utils.navigationKey.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => ChannelInfoPage(
                              controller: _miniPlayerController,
                              youtubeVideo: video),
                        ),
                      );
                    },
                    child: Container(
                      height: Utils.blockWidth * 7,
                      width: Utils.blockWidth * 7,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: video.uploaderChannelInfo == null
                          ? channelFuture.when(
                              data: (data) {
                                return Container(
                                  // borderRadius: BorderRadius.circular(50),
                                  // child: _FadeInImageWidget(
                                  //   url: data != null
                                  //       ? data.avatarUrl
                                  //       : Utils.dummyPictureUrl,
                                  // ),
                                  height: Utils.blockWidth * 7,
                                  width: Utils.blockWidth * 7,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          data != null
                                              ? data.avatarUrl
                                                  .replaceAll("=s48", "=s40")
                                              : Utils.dummyPictureUrl),
                                    ),
                                  ),
                                );
                              },
                              loading: () => const CircularProgressIndicator(),
                              error: (obj, stk) => const SizedBox(),
                            )
                          : Container(
                              // borderRadius: BorderRadius.circular(50),
                              // child: _FadeInImageWidget(
                              //   url: video.uploaderChannelInfo!.avatarUrl,
                              // ),
                              height: Utils.blockWidth * 7,
                              width: Utils.blockWidth * 7,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      video.uploaderChannelInfo!.avatarUrl),
                                ),
                              ),
                            ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Utils.blockWidth * 2.2, right: Utils.blockWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              video.videoName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: Utils.blockWidth),
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${video.uploaderName}   •   ${video.viewCount.toString().convertToViews()} views  •   ${video.textualUploadDate}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              // maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.more_vert)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FadeInImageWidget extends StatelessWidget {
  final String url;
  final String? altImageUrl;
  const _FadeInImageWidget({
    Key? key,
    required this.url,
    this.altImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (context, s, d) => CachedNetworkImage(
        imageUrl: altImageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      // decoration: BoxDecoration(
      //   image: DecorationImage( image: CachedNetworkImageProvider(url),
      //   imageErrorBuilder: (context, obj, stackTrace) {
      //     return CachedNetworkImage(
      //       imageUrl: altImageUrl!,
      //       fit: BoxFit.cover,
      //       width: double.infinity,
      //     );
      //   },)
      // ),
    );
    return GestureDetector(
      child: FadeInImage(
        width: double.infinity,
        fit: BoxFit.fill,
        placeholder: MemoryImage(Utils.transparentImage),
        image: CachedNetworkImageProvider(url),
        imageErrorBuilder: (context, obj, stackTrace) {
          return CachedNetworkImage(
            imageUrl: altImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        },
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
