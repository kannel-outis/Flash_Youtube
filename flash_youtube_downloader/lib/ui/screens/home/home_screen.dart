import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/providers/home/states/youtube_controller_state.dart';
import 'package:flash_youtube_downloader/ui/screens/mini_player/mini_player.dart';
import 'package:flash_youtube_downloader/ui/widgets/custom_will_scope.dart';
import 'package:flash_youtube_downloader/ui/widgets/grid_view_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';
import '/utils/utils.dart';

final trendingVideos = FutureProvider<List<YoutubeVideo>?>((ref) {
  return Extract().getTrendingVideos();
});

final videoStateFullInfo = FutureProvider<YoutubeVideoInfo>((ref) {
  final videoState = ref.watch(currentVideoStateProvider);
  return videoState!.getFullInformation;
});
final youtubePlayerController =
    StateNotifierProvider<YoutubeControllerState, YoutubePlayerController?>(
        (ref) {
  return YoutubeControllerState();
});

final miniPlayerC = ChangeNotifierProvider<MiniPlayerController>((ref) {
  return MiniPlayerController(
      minHeight: Utils.blockHeight * 13,
      maxHeight: Utils.blockHeight * 100,
      startOpen: false,
      animationDuration: const Duration(milliseconds: 200));
});

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final _miniPlayerController = watch(miniPlayerC);
    return Scaffold(
      body: CustomWillScope(
        controller: _miniPlayerController,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            toolbarHeight: 70,
            elevation: 0.0,
            title: Row(
              children: [
                SizedBox(
                  child: Image.asset(
                    "assets/icons/youtube.png",
                    scale: 18.0,
                  ),
                ),
                const Text("Trending"),
              ],
            ),
            actions: const [
              Icon(Icons.search),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          body: _Trending(_miniPlayerController),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.local_fire_department),
      //       label: "",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.trending_down),
      //       label: "",
      //     ),
      //   ],
      // ),
    );
  }
}

// ignore: must_be_immutable
class _Trending extends ConsumerWidget {
  final MiniPlayerController _miniPlayerController;
  _Trending(this._miniPlayerController);
  int gridCount = 0;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureTrendingVideos = watch(trendingVideos);

    final maxWidth = () {
      double screenWidth = 0.0;
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        screenWidth =
            MediaQuery.of(context).size.width - (20 + Utils.blockWidth * 4);
        if (screenWidth < 550) {
          gridCount = 1;
          return screenWidth;
        } else if (screenWidth > 550 && screenWidth < 960) {
          gridCount = 2;

          return screenWidth / 2;
        } else {
          gridCount = 3;
          return screenWidth / 3;
        }
      }
      screenWidth = MediaQuery.of(context).size.height - 20;
      if (screenWidth < 550) {
        gridCount = 2;
        return screenWidth;
      } else if (screenWidth > 550 && screenWidth < 960) {
        gridCount = 3;
        return screenWidth / 2;
      } else {
        gridCount = 4;
        return screenWidth / 3;
      }
    }();

    final heightWithMaxHeight = () {
      if (MediaQuery.of(context).size.width < 550) {
        return 250;
      } else if (MediaQuery.of(context).size.width > 700) {
        return 400;
      }
      return Utils.blockHeight * 18;
    }();
    return futureTrendingVideos.when(
      data: (data) {
        return Padding(
          padding: EdgeInsets.all(Utils.blockWidth * 2.0),
          child: GridViewWidget(
              gridCount: gridCount,
              maxWidth: maxWidth,
              data: data!,
              heightWithMaxHeight: heightWithMaxHeight,
              miniPlayerController: _miniPlayerController),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (obj, stackTrace) {
        return const Center(
          child: Text("Something Went Wrong....."),
        );
      },
    );
  }
}
