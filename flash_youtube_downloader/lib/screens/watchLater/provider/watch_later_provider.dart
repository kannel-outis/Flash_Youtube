import 'package:flash_youtube_downloader/screens/watchLater/states/watch_later_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: avoid_classes_with_only_static_members
class WatchLaterProvider {
  static final hiveOpsProvider =
      ChangeNotifierProvider<WatchLaterChangeNotifier>(
    (ref) {
      return WatchLaterChangeNotifier();
    },
  );
}
