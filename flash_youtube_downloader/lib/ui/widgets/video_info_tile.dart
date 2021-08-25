import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class VideoInfoTile extends StatelessWidget {
  final YoutubeVideo video;
  const VideoInfoTile({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: Utils.blockHeight * 28,
      width: double.infinity,
      constraints: const BoxConstraints(
        maxHeight: 400,
        minHeight: 250,
      ),
      child: Column(
        children: [
          Container(
            height: Utils.blockHeight * 20,
            // color: Colors.black,
            child: Stack(
              children: [
                FadeInImageWidget(
                  height: Utils.blockHeight * 20,
                  url: video.thumbnailUrl!,
                  width: double.infinity,
                  placeHolderChild: Container(
                    height: Utils.blockHeight * 20,
                    width: double.infinity,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                Positioned(
                  height: 20,
                  width: 50,
                  bottom: 20,
                  right: 20,
                  child: Container(
                    color: Colors.black.withOpacity(.5),
                    child: Center(
                      child: Text(
                        video.duration.toString(),
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
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              video.videoName ?? "name",
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
                        const SizedBox(height: 10),
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${video.uploaderName}   •   ${video.viewCount} views  •   ${video.textualUploadDate}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
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

class FadeInImageWidget extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  final Widget placeHolderChild;
  const FadeInImageWidget({
    Key? key,
    required this.height,
    required this.url,
    required this.width,
    required this.placeHolderChild,
  }) : super(key: key);

  @override
  _FadeInImageWidgetState createState() => _FadeInImageWidgetState();
}

class _FadeInImageWidgetState extends State<FadeInImageWidget>
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
      // fit: BoxFit.cover,
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
