import 'package:flash_youtube_downloader/components/custom_nested_view.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/history.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchHistory extends StatelessWidget {
  const WatchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomWillScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          // elevation: 0.0,
          title: Text(
            "Watch Later",
            style: theme.textTheme.headline5,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: ValueListenableBuilder<Box<HiveWatchHistory>>(
            valueListenable:
                Hive.box<HiveWatchHistory>(HiveInit.hiveWatchHistoryBoxName)
                    .listenable(),
            builder: (context, box, child) {
              final watchHistory = box.values.toList().reversed.toList();
              return ListView.builder(
                itemCount: watchHistory.length,
                itemBuilder: (context, index) {
                  return VideoInfoTile(
                    video: watchHistory[index].video,
                    index: index,
                    isPlayListInfo: true,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
