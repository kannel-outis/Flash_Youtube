import 'package:async/async.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/current_video_state_provider.dart';
import 'package:flash_youtube_downloader/ui/widgets/video_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/utils.dart';

final trendingVideos = FutureProvider.autoDispose<List<YoutubeVideo>?>((ref) {
  return AsyncMemoizer<List<YoutubeVideo>?>()
      .runOnce(() => Extract().getTrendingVideos());
});

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);
  int gridCount = 0;

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    final futureTrendingVideos = ref(trendingVideos);
    final currentVideoStateNotifier = ref(currentVideoStateProvider.notifier);
    final theme = Theme.of(context);
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
      body: futureTrendingVideos.when(
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
  }
}
