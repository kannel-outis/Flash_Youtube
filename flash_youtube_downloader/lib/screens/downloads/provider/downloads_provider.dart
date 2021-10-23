import 'package:flash_youtube_downloader/screens/downloads/state/download_change_notifier.dart';
import 'package:hooks_riverpod/all.dart';

// ignore: avoid_classes_with_only_static_members
class DownloadsProvider {
  static final downloadChangeNotifierProvider =
      ChangeNotifierProvider<DownloadChangeNotifier>(
    (ref) {
      return DownloadChangeNotifier();
    },
  );
}
