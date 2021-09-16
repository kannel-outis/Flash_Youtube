import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentVideoStateProvider =
    StateNotifierProvider.autoDispose<CurrentVideoStateProvider, YoutubeVideo?>(
        (ref) {
  return CurrentVideoStateProvider(null);
});

class CurrentVideoStateProvider extends StateNotifier<YoutubeVideo?> {
  CurrentVideoStateProvider(YoutubeVideo? state) : super(state);

  // ignore: use_setters_to_change_properties
  void setVideoState(YoutubeVideo video) {
    state = null;
    state = video;
  }

  void disposeVideoState() {
    state = null;
  }
}
