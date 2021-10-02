import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: avoid_classes_with_only_static_members
class PlaylistProviders {
  static final playlistFuture =
      FutureProvider.autoDispose.family<PlaylistInfo, String>(
    (ref, url) async {
      return Extract().getPlaylistInfo(url);
    },
  );
}
