import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChannelVideoState extends StateNotifier<bool> {
  ChannelVideoState(GrowablePage growablePage)
      : _growablePage = growablePage,
        super(false);

  late final GrowablePage _growablePage;

  bool get hasReachedLastPage =>
      _growablePage.manager.page!.hasNextPage == false;

  Future<void> fetchNextItems() async {
    if (!state && _growablePage.manager.page!.hasNextPage) {
      state = true;
      await _growablePage.manager
          .nextpageItems()
          .then((value) => state = false);
    }
  }
}
