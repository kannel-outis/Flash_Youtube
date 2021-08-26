import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import '/utils/extensions.dart';

class VideoInfoTile extends StatelessWidget {
  final YoutubeVideo video;
  final double maxWidth;
  const VideoInfoTile({Key? key, required this.video, required this.maxWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              // .replaceAll("hqdefault", "maxresdefault")
              // .toString()
              children: [
                _FadeInImageWidget(
                  altImage: video.hqdefault,
                  url: video.thumbnailUrl!,
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
                  height: Utils.blockWidth * 7,
                  width: Utils.blockWidth * 7,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: video.uploaderChannelInfo == null
                      ? FutureBuilder<Channel>(
                          future: video.getUploaderChannelInfo(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: _FadeInImageWidget(
                                url: snapshot.data!.avatarUrl,
                                placeHolderChild: const SizedBox(),
                              ),
                            );
                          },
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: _FadeInImageWidget(
                            url: video.uploaderChannelInfo!.avatarUrl,
                            placeHolderChild: const SizedBox(),
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

class _FadeInImageWidget extends StatefulWidget {
  final String url;
  final String? altImage;
  final Widget placeHolderChild;
  const _FadeInImageWidget({
    Key? key,
    required this.url,
    this.altImage,
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
        if (widget.altImage == null) return const SizedBox();
        return Image(
          width: double.infinity,
          fit: BoxFit.fill,
          image: NetworkImage(widget.altImage!),
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
