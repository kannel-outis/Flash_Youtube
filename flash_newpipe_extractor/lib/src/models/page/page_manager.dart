import 'package:flash_newpipe_extractor/src/models/page/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart' as p;
import 'package:flutter/widgets.dart';

import '../../method_calls.dart';

class PageManager<T, K extends GrowablePage<T, K>> {
  final String? query;
  final String? channelUrl;
  final String? videoUrl;
  PageManager({
    this.query,
    this.channelUrl,
    this.videoUrl,
  });

  int _pageIncrement = 1;
  K? _child;

  @protected
  set child(K? child) {
    _child = child;
  }

  p.Page? _page;
  p.Page? get page => _page;
  set setPage(p.Page page) {
    _page = page;
  }

  Future<void> nextpageItems() async {
    if (_child == null) {
      return;
    }
    await FlashMethodCalls.getItemsNextPage(_child!).then((value) {
      _page = _page!.copyWith(
        pageNumber: _page!.pageNumber + _pageIncrement,
      );
    });
  }
}
