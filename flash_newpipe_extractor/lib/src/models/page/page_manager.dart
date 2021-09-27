import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_newpipe_extractor/src/models/page/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart' as p;
import 'package:flutter/widgets.dart';

import '../../method_calls.dart';

class PageManager<T, K extends GrowablePage<T, K>> {
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
    // TODO: engineer to work with search
    if (_child == null) {
      return;
    }
    await FlashMethodCalls.getItemsNextPage(_child!, _child is Comments)
        .then((value) {
      _page = _page!.copyWith(
        pageNumber: _page!.pageNumber + _pageIncrement,
      );
    });
  }
}
