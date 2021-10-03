import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/mini_player/components/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: avoid_classes_with_only_static_members
class MiniPlayerProviders {
  static final miniPlayerC =
      ChangeNotifierProvider<MiniPlayerController>((ref) {
    return MiniPlayerController(
        minHeight: Utils.blockHeight * 13.5,
        maxHeight: Utils.blockHeight * 100,
        startOpen: false,
        animationDuration: const Duration(milliseconds: 300));
  });
  static final commentsprovider =
      FutureProvider.family<Comments?, YoutubeVideoInfo>((ref, videoInfo) {
    return videoInfo.getComments();
  });
}
