import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import "package:flutter/material.dart";
import './../../../utils/extensions.dart';

class VideoInfoTile extends StatelessWidget {
  final YoutubeVideo video;
  final bool isSearch;
  const VideoInfoTile({Key? key, required this.video, this.isSearch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSearch) {
      return Container(
        // color: Colors.black,
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
                color: Colors.red,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
    return Container(
      // color: Colors.black,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Container(
            width: 180,
            color: Colors.red,
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
                    height: Utils.blockWidth * 10,
                    child: Column(
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
                      ],
                    ),
                  ),
                  // SizedBox(height: Utils.blockWidth),
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
