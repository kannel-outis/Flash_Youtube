import 'package:flash_newpipe_extractor/src/models/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';

import '../../method_calls.dart';

// class PageManager<T extends PageManager<T>> {
class PageManager<K, T extends GrowablePageList<K, T>> {
  int _pageIncrement = 1;
  T? _child;
  set child(T? child) {
    _child = child;
  }

  Page? _page;
  Page? get page => _page;
  set setPage(Page page) {
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
