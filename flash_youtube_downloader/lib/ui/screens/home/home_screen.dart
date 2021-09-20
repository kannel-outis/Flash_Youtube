import 'package:async/async.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/providers/home/states/youtube_controller_state.dart';
import 'package:flash_youtube_downloader/ui/screens/mini_player/mini_player.dart';
import 'package:flash_youtube_downloader/ui/widgets/grid_view_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';
import '/utils/utils.dart';

final trendingVideos = FutureProvider<List<YoutubeVideo>?>((ref) {
  return AsyncMemoizer<List<YoutubeVideo>?>()
      .runOnce(() => Extract().getTrendingVideos());
});

final videoStateFullInfo = FutureProvider<YoutubeVideoInfo>((ref) {
  final videoState = ref.watch(currentVideoStateProvider);
  return AsyncMemoizer<YoutubeVideoInfo>()
      .runOnce(() => videoState!.getFullInformation);
});
final youtubePlayerController =
    StateNotifierProvider<YoutubeControllerState, YoutubePlayerController?>(
        (ref) {
  return YoutubeControllerState();
});

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int gridCount = 0;
  MiniPlayerController _miniPlayerController = MiniPlayerController.nil();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _miniPlayerController = MiniPlayerController(
      minHeight: (MediaQuery.of(context).size.height / 100) * 13,
      maxHeight: MediaQuery.of(context).size.height,
      startOpen: false,
      animationDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final theme = Theme.of(context);
      final currentVideoState = watch(currentVideoStateProvider);
      return Scaffold(
        body: Stack(
          children: [
            Scaffold(
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
            if (currentVideoState != null)
              MiniPlayerWidget(controller: _miniPlayerController)
            else
              const SizedBox(),
          ],
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
    });
  }
}

class _Trending extends ConsumerWidget {
  final MiniPlayerController _miniPlayerController;
  const _Trending(this._miniPlayerController);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    int gridCount = 0;
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
