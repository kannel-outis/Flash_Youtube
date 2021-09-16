import 'package:async/async.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/states/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/providers/home/states/youtube_controller_state.dart';
import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/ui/widgets/video_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player/youtube_player.dart';
import '/utils/utils.dart';

final trendingVideos = FutureProvider.autoDispose<List<YoutubeVideo>?>((ref) {
  return AsyncMemoizer<List<YoutubeVideo>?>()
      .runOnce(() => Extract().getTrendingVideos());
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
      animationDuration: const Duration(milliseconds: 300),
    )..addListener(() {
        print(_miniPlayerController.percentage);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final theme = Theme.of(context);
      final currentVideoState = watch(currentVideoStateProvider);
      final controller = watch(youtubePlayerController);
      return Scaffold(
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
        body: Stack(
          children: [
            _Trending(_miniPlayerController),
            if (currentVideoState != null)
              MiniPlayer(
                miniPlayerController: _miniPlayerController,
                playerChild: YoutubePlayer(
                  controller: controller!,
                  colors: YoutubePlayerColors.auto(
                    barColor: Colors.white.withOpacity(.4),
                    bufferedColor: Colors.white.withOpacity(.8),
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_down),
              label: "",
            ),
          ],
        ),
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
    final currentVideoStateNotifier = watch(currentVideoStateProvider.notifier);
    final youtubePlayerControllerNotifier =
        watch(youtubePlayerController.notifier);
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
          child: GridView.builder(
            itemCount: data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
              crossAxisSpacing: 15,
              childAspectRatio: maxWidth / heightWithMaxHeight,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  currentVideoStateNotifier.setVideoState(data[index]);
                  youtubePlayerControllerNotifier.youtubeControllerState =
                      data[index].url;
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _miniPlayerController.openMiniPlayer();
                  });
                  // print(youtubePlayerControllerNotifier.state!.isDisposed);
                },
                child: SizedBox(
                  child: VideoInfoTile(
                    video: data[index],
                    maxWidth: maxWidth,
                  ),
                ),
              );
            },
          ),
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
