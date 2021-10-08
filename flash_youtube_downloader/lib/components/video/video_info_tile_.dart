import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/change_current_playing.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import './../../../utils/extensions.dart';

class VideoInfoTile extends ConsumerWidget {
  final YoutubeVideo video;
  final bool isSearch;
  final bool isPlayListInfo;
  final int index;
  final Widget? leadingChild;
  const VideoInfoTile(
      {Key? key,
      required this.video,
      this.isSearch = false,
      this.index = 0,
      this.leadingChild,
      this.isPlayListInfo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPlaying =
        watch(ChangeCurrentPlaying.changeCurrentPlayingProvider);
    if (isSearch) {
      return GestureDetector(
        onTap: () {
          currentPlaying.changeCurrentVideoplaying(video);
        },
        child: _IsSearchTile(
          video: video,
        ),
      );
    } else if (isPlayListInfo) {
      return GestureDetector(
        onTap: () {
          currentPlaying.changeCurrentVideoplaying(video);
        },
        child: _IsPlaylistInfo(
          video: video,
          child: leadingChild ??
              Text(
                (index + 1).toString(),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.grey,
                    ),
              ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        currentPlaying.changeCurrentVideoplaying(video);
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(left: 10),
        width: double.infinity,
        height: Utils.blockHeight * 7.41,
        child: Row(
          children: [
            Container(
              width: 180,
              color: Utils.placeHolderColor,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: video.hqdefault,
                    fit: BoxFit.cover,
                    errorWidget: (context, s, d) => CachedNetworkImage(
                      imageUrl: video.mqdefault,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Column(
                  children: [
                    SizedBox(
                      // height: Utils.blockWidth * 10,
                      child: Column(
                        children: [
                          Container(
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
                        ],
                      ),
                    ),
                    SizedBox(height: Utils.blockWidth),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${video.viewCount.toString().convertToViews()} views  •   ${video.textualUploadDate}",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.grey,
                            ),
                        textAlign: TextAlign.left,
                        // maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IsPlaylistInfo extends StatelessWidget {
  final YoutubeVideo video;
  final Widget child;
  const _IsPlaylistInfo({Key? key, required this.video, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      color: Colors.transparent,

      margin: const EdgeInsets.only(bottom: 20),
      // padding: const EdgeInsets.only(left: 10),
      width: double.infinity,
      height: Utils.blockHeight * 7.41,
      child: Row(
        children: [
          Container(
            width: 70,
            color: Colors.transparent,
            child: Center(
              child: child,
            ),
          ),
          Container(
            width: 180,
            color: Utils.placeHolderColor,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: video.hqdefault,
                  fit: BoxFit.cover,
                  errorWidget: (context, s, d) => CachedNetworkImage(
                    imageUrl: video.mqdefault,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: Container(
                    color: Colors.black.withOpacity(.7),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Column(
                children: [
                  SizedBox(
                    // height: Utils.blockWidth * 10,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            video.videoName!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Utils.blockWidth),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      video.uploaderName ?? "Unknown Channel Name",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.left,
                      // maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IsSearchTile extends StatelessWidget {
  final YoutubeVideo video;
  const _IsSearchTile({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      color: Colors.transparent,

      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 10),
      width: double.infinity,
      // height: 165,
      height: Utils.blockHeight * 12.22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Utils.placeHolderColor,
              child: Stack(
                children: [
                  Align(
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: video.thumbnailUrl!,
                      // height: Utils.blockHeight * 12.5,
                      fit: BoxFit.cover,
                      errorWidget: (context, s, d) => CachedNetworkImage(
                        imageUrl: video.mqdefault,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Column(
                children: [
                  SizedBox(
                    // height: Utils.blockWidth * 10,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            video.videoName!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Utils.blockWidth),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${video.viewCount.toString().convertToViews()} views  •   ${video.textualUploadDate}",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.left,
                      // maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
