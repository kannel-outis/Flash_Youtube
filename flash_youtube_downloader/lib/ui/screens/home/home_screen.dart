import 'package:async/async.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/widgets/video_info_tile.dart';
import 'package:flutter/material.dart';
import '/utils/utils.dart';
// import '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AsyncMemoizer<List<YoutubeVideo>?> _memoizer;
  int gridCount = 0;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer<List<YoutubeVideo>?>();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<YoutubeVideo>?>(
        future: _memoizer.runOnce(() => Extract().getTrendingVideos()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(Utils.blockWidth * 2.0),
            // child: SingleChildScrollView(
            //   physics: const AlwaysScrollableScrollPhysics(),
            //   child: Wrap(
            //     spacing: 10,
            //     children: List.generate(
            //       snapshot.data!.length,
            //       (index) => Container(
            //         color: Colors.black,
            //         child: VideoInfoTile(
            //           video: snapshot.data![index],
            //           maxWidth: maxWidth,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            child: GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCount,
                crossAxisSpacing: 10,
                // mainAxisSpacing: 20,

                ///width / container height to get aspectRatio
                childAspectRatio: maxWidth / heightWithMaxHeight,
              ),
              itemBuilder: (context, index) {
                return Container(
                  // color: Colors.white,
                  child: VideoInfoTile(
                    video: snapshot.data![index],
                    maxWidth: maxWidth,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
