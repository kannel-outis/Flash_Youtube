import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/screens/channel/channel_info.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flutter/material.dart';
import '/utils/extensions.dart';
import '/utils/utils.dart';

class CommentTile extends StatelessWidget {
  final CommentInfo e;
  final MiniPlayerController _miniPlayerController;

  const CommentTile(this._miniPlayerController, {Key? key, required this.e})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.grey, width: .1),
        bottom: BorderSide(color: Colors.grey, width: .1),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _miniPlayerController.closeMiniPlayer();
              Utils.navigationKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => ChannelInfo(
                    controller: _miniPlayerController,
                    uploaderUrl: e.uploaderUrl,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: Utils.blockWidth * 7,
              width: Utils.blockWidth * 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(e.uploaderAvatarUrl ??
                      "https://s.ytimg.com/yts/img/channels/c4/default_banner-vflYp0HrA.jpg"),
                  placeholder: MemoryImage(Utils.transparentImage),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${e.uploaderName}  •  ${e.textualUploadDate} ",
                          style: theme.textTheme.bodyText2!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(e.commentText ?? "cannot load this at the minute",
                            style: theme.textTheme.bodyText1),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.thumb_up_outlined,
                                size: theme.primaryIconTheme.size,
                              ),
                              const SizedBox(width: 7),
                              Text(e.likeCount.toString().convertToViews())
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        if (e.isHeartedByUploader != null &&
                            e.isHeartedByUploader!)
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: Utils.blockWidth * 2.7,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
