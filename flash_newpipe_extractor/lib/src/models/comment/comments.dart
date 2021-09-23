import 'package:flash_newpipe_extractor/src/models/comment/comment_info.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';

import '../growable_page_list.dart';

class Comments extends PageManager<CommentInfo, Comments>
    implements GrowablePage<CommentInfo, Comments> {
  final bool isDisabled;
  final String url;

  Comments({
    required this.isDisabled,
    required this.url,
  }) {
    super.child = this;
  }
  List<CommentInfo> _commentsInfo = [];
  List<CommentInfo> get comments => _commentsInfo;

  @override
  void addToGrowableList(CommentInfo item) {
    _commentsInfo.add(item);
  }

  @override
  Comments? get child => this;

  @override
  Page? get childPage => super.page;
}
