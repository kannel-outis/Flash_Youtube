import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import '/utils/extensions.dart';

class VideoInfoTile extends StatelessWidget {
  final YoutubeVideo video;
  const VideoInfoTile({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.blockHeight * 31,
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 250,
      ),
      child: Column(
        children: [
          Container(
            height: Utils.blockHeight * 23,
            // color: Colors.black,
            child: Stack(
              children: [
                _FadeInImageWidget(
                  altImage: video.hqdefault,
                  height: Utils.blockHeight * 20,
                  url: video.thumbnailUrl!
                      .replaceAll("hqdefault", "maxresdefault")
                      .toString(),
                  width: double.infinity,
                  placeHolderChild: Container(
                    height: Utils.blockHeight * 20,
                    width: double.infinity,
                    color: Theme.of(context).backgroundColor,
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Utils.blockWidth * 12,
                  width: Utils.blockWidth * 12,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50),
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

class _FadeInImageWidget extends StatefulWidget {
  final String url;
  final String altImage;
  final double height;
  final double width;
  final Widget placeHolderChild;
  const _FadeInImageWidget({
    Key? key,
    required this.height,
    required this.url,
    required this.altImage,
    required this.width,
    required this.placeHolderChild,
  }) : super(key: key);

  @override
  _FadeInImageWidgetState createState() => _FadeInImageWidgetState();
}

class _FadeInImageWidgetState extends State<_FadeInImageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(widget.url),
      width: double.infinity,
      fit: BoxFit.fill,
      errorBuilder: (context, t, u) {
        return Image(
          width: double.infinity,
          fit: BoxFit.fill,
          image: NetworkImage(widget.altImage),
        );
      },
      frameBuilder: (context, child, v, b) {
        if (v == null)
          // ignore: curly_braces_in_flow_control_structures
          return FadeTransition(
            opacity: Tween<double>(begin: 0, end: -1).animate(_controller),
            child: widget.placeHolderChild,
          );
        _controller.forward();
        return Stack(
          fit: StackFit.expand,
          children: [
            FadeTransition(
              opacity: _controller,
              child: child,
            ),
          ],
        );
      },
    );
  }
}
