import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final channelVideoProvider = StateNotifierProvider.autoDispose
    .family<ChannelVideoProvider, bool, Channel>((ref, channel) {
  print(channel.name);
  return ChannelVideoProvider(channel);
});

class ChannelVideoProvider extends StateNotifier<bool> {
  ChannelVideoProvider(Channel channel)
      : _channel = channel,
        super(false);

  late final Channel _channel;

  bool _hasReachedEnd = false;

  bool get hasReachedLastPage => _channel.page!.hasNextPage == false;

  // ignore: avoid_setters_without_getters
  set hasReachedEnd(bool reachedEnd) {
    _hasReachedEnd = reachedEnd;
  }

  Future<void> fetchNextItems() async {
    if (_hasReachedEnd && !state && _channel.page!.hasNextPage) {
      state = true;
      await _channel.nextpageItems().then((value) => state = false);
    }
  }
}
