import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/components/video/pop_menu.dart';
import 'package:flash_youtube_downloader/providers/change_current_playing.dart';
import 'package:flash_youtube_downloader/screens/channel/channel_info.dart';
import 'package:flash_youtube_downloader/screens/channel/providers/channel_providers.dart';
import 'package:flash_youtube_downloader/screens/mini_player/components/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/extensions.dart';
import 'duration_stack.dart';

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
    final channelFuture = reader(ChannelProviders.channelInfoProvider(video));
    final currentPlaying =
        reader(ChangeCurrentPlaying.changeCurrentPlayingProvider);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              currentPlaying.changeCurrentVideoplaying(video);
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
                  DurationStack(video: video),
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
                            youtubeVideo: video,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: Utils.blockWidth * 7,
                      width: Utils.blockWidth * 7,
                      decoration: BoxDecoration(
                        color: isDarkTheme
                            ? Utils.placeHolderColor
                            : Utils.placeHolderColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: video.uploaderChannelInfo == null
                          ? channelFuture.when(
                              data: (data) {
                                return Container(
                                  height: Utils.blockWidth * 7,
                                  width: Utils.blockWidth * 7,
                                  decoration: BoxDecoration(
                                    color: isDarkTheme
                                        ? Utils.placeHolderColor
                                        : Utils.placeHolderColor
                                            .withOpacity(.1),
                                    borderRadius: BorderRadius.circular(50),
                                    // image: DecorationImage(
                                    //   image: CachedNetworkImageProvider(
                                    //     data != null
                                    //         ? data.avatarUrl
                                    //             .replaceAll("=s48", "=s40")
                                    //         : Utils.dummyPictureUrl,
                                    //   ),
                                    // ),
                                  ),
                                );
                              },
                              loading: () => const CircularProgressIndicator(
                                strokeWidth: .5,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              error: (obj, stk) => const SizedBox(),
                            )
                          : Container(
                              height: Utils.blockWidth * 7,
                              width: Utils.blockWidth * 7,
                              decoration: BoxDecoration(
                                color: isDarkTheme
                                    ? Utils.placeHolderColor
                                    : Utils.placeHolderColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    video.uploaderChannelInfo!.avatarUrl,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Utils.blockWidth * 2.2,
                      right: Utils.blockWidth,
                    ),
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
                              "${video.uploaderName}   ???   ${video.viewCount.toString().convertToViews()} views  ???   ${video.textualUploadDate}",
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
                // InkWell(
                //   onTap: () {
                //     print("object");
                //   },
                //   borderRadius: BorderRadius.circular(50),
                //   child: const SizedBox(
                //     height: 30,
                //     width: 30,
                //     child: Icon(
                //       Icons.more_vert,
                //       size: 18,
                //     ),
                //   ),
                // ),
                CustomPopMenu(video: video),
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, value) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: isDarkTheme
              ? Utils.placeHolderColor
              : Utils.placeHolderColor.withOpacity(.1),
        );
      },
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
