import 'package:flash_newpipe_extractor/src/models/comment_info.dart';

class Comments {
  final bool isDisabled;
  final List<CommentInfo>? comments;

  Comments({
    required this.isDisabled,
    this.comments,
  });
}
