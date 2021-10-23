import 'package:flash_newpipe_extractor/src/models/comment/comment_info.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';

import '../page/growable_page_list.dart';

class Comments extends PageManager<CommentInfo, Comments>
    implements GrowablePage<CommentInfo, Comments> {
  final bool isDisabled;
  final String url;

  Comments({
    required this.isDisabled,
    required this.url,
  }) : super(value: url) {
    super.child = this;
  }
  List<CommentInfo> _commentsInfo = [];

  @override
  List<CommentInfo> get growableListItems => _commentsInfo;

  @override
  void addToGrowableList(CommentInfo item) {
    _commentsInfo.add(item);
  }

  @override
  PageManager<CommentInfo, Comments> get manager => this;

  @override
  String get type => "comments";
}
