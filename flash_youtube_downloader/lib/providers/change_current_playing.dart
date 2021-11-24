import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/home/providers/home_providers.dart';
import 'package:flash_youtube_downloader/screens/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/screens/home/states/youtube_controller_state.dart';
import 'package:flash_youtube_downloader/screens/mini_player/components/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/screens/mini_player/providers/miniplayer_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeCurrentPlaying {
  static final changeCurrentPlayingProvider =
      Provider<ChangeCurrentPlaying>((ref) {
    final currentVideoState =
        ref.watch(HomeProviders.currentVideoStateProvider);
    final currentVideoStateNotifier =
        ref.watch(HomeProviders.currentVideoStateProvider.notifier);
    final youtubePlayerControllerNotifier =
        ref.watch(HomeProviders.youtubePlayerController.notifier);
    final miniPlayerController = ref.watch(MiniPlayerProviders.miniPlayerC);
    return ChangeCurrentPlaying(
      miniPlayerController,
      currentVideoState,
      currentVideoStateNotifier,
      youtubePlayerControllerNotifier,
    );
  });

  final MiniPlayerController _miniPlayerController;
  final YoutubeVideo? currentVideoState;
  final CurrentVideoStateProvider currentVideoStateNotifier;
  final YoutubeControllerState youtubePlayerControllerNotifier;

  ChangeCurrentPlaying(
    this._miniPlayerController,
    this.currentVideoState,
    this.currentVideoStateNotifier,
    this.youtubePlayerControllerNotifier,
  );
  void changeCurrentVideoplaying(YoutubeVideo video, [String? videoUrl]) {
    if (currentVideoState == null || video.url != currentVideoState!.url) {
      currentVideoStateNotifier.setVideoState(video);
      youtubePlayerControllerNotifier.youtubeControllerState =
          videoUrl ?? video.url;
    }
    if (_miniPlayerController.isClosed) {
      Future.delayed(const Duration(milliseconds: 20), () {
        _miniPlayerController.openMiniPlayer();
      });
    }
  }
}
