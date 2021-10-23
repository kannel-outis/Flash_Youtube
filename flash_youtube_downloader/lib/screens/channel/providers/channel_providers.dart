import 'package:async/async.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/channel/states/channel_video_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: avoid_classes_with_only_static_members
class ChannelProviders {
  static final _extract = Provider<Extract>((ref) => const Extract());

  static final channelInfoExtractProvider =
      FutureProvider.family<ChannelInfo?, String>((ref, uploaderUrl) {
    return ref.read(_extract).getChannelInfo(uploaderUrl);
  });

  static final channelInfoProvider =
      FutureProvider.family<ChannelInfo?, YoutubeVideo>((ref, video) {
    return AsyncMemoizer<ChannelInfo?>()
        .runOnce(() => video.getUploaderChannelInfo());
  });
  static final channelVideoProvider = StateNotifierProvider.autoDispose
      .family<ChannelVideoState, bool, GrowablePage>((ref, growablePage) {
    return ChannelVideoState(growablePage);
  });
}
