import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/material.dart';
import '/utils/extensions.dart';
import '/utils/utils.dart';

class CommentTile extends StatelessWidget {
  final CommentInfo e;

  const CommentTile({Key? key, required this.e}) : super(key: key);
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: Utils.blockWidth * 7,
            width: Utils.blockWidth * 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FadeInImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(e.uploaderAvatarUrl!),
                placeholder: MemoryImage(Utils.transparentImage),
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
                          "${e.uploaderName!}  •  ${e.textualUploadDate!} ",
                          style: theme.textTheme.bodyText2!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(e.commentText!, style: theme.textTheme.bodyText1),
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
                              Text(e.likeCount!.toString().convertToViews())
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        if (e.isHeartedByUploader!)
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
