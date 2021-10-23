import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/screens/home/states/home_state.dart';
import 'package:flash_youtube_downloader/screens/home/states/page_state.dart';
import 'package:flash_youtube_downloader/screens/home/states/youtube_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';

// ignore: avoid_classes_with_only_static_members
class HomeProviders {
  static final trendingVideos = FutureProvider<List<YoutubeVideo>?>((ref) {
    return const Extract().getTrendingVideos();
  });

  static final videoStateFullInfo =
      FutureProvider.family<YoutubeVideoInfo, YoutubeVideo?>((ref, video) {
    final videoState = video ?? ref.watch(currentVideoStateProvider);
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
        const Extract(),
      );
    },
  );

  static final currentVideoStateProvider =
      StateNotifierProvider<CurrentVideoStateProvider, YoutubeVideo?>((ref) {
    return CurrentVideoStateProvider(null);
  });

  static final pageStateProvider =
      StateNotifierProvider.family<PageState, int, PageController>(
          (ref, controller) {
    return PageState(controller);
  });
}
