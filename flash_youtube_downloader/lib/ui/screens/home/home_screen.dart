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

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer<List<YoutubeVideo>?>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              padding: EdgeInsets.all(Utils.blockHeight * 1.2),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      VideoInfoTile(video: snapshot.data![index]),
                      const SizedBox(height: 10)
                    ],
                  );
                },
              ),
            );
          }),
    );
  }
}
