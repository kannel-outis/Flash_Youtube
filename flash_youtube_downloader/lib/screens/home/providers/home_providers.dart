import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/screens/home/states/home_state.dart';
import 'package:flash_youtube_downloader/screens/home/states/youtube_controller_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';

// ignore: avoid_classes_with_only_static_members
class HomeProviders {
  static final trendingVideos = FutureProvider<List<YoutubeVideo>?>((ref) {
    return Extract().getTrendingVideos();
  });

  static final videoStateFullInfo = FutureProvider<YoutubeVideoInfo>((ref) {
    final videoState = ref.watch(currentVideoStateProvider);
    return videoState!.getFullInformation;
  });
  static final youtubePlayerController =
      StateNotifierProvider<YoutubeControllerState, YoutubePlayerController?>(
          (ref) {
    return YoutubeControllerState();
  });

  static final homeProvider = ChangeNotifierProvider<HomeState>(
    (ref) {
      return HomeState(
        Extract(),
      );
    },
  );

  static final currentVideoStateProvider =
      StateNotifierProvider<CurrentVideoStateProvider, YoutubeVideo?>((ref) {
    return CurrentVideoStateProvider(null);
  });
}