import 'package:flash_youtube_downloader/components/custom_nested_view.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/watch_later.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchLater extends StatelessWidget {
  const WatchLater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomWillScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0.0,
          title: Text(
            "Watch Later",
            style: theme.textTheme.headline5,
          ),
        ),
        body: ValueListenableBuilder<Box<HiveWatchLater>>(
          valueListenable:
              Hive.box<HiveWatchLater>(HiveInit.hiveWatchLaterBoxName)
                  .listenable(),
          builder: (context, box, child) {
            final watchLaterList = box.values.toList().reversed.toList();
            return CustomNestedView(
              videoCount: watchLaterList.length,
              child: ListView.builder(
                itemCount: watchLaterList.length,
                itemBuilder: (context, index) {
                  return VideoInfoTile(
                    video: watchLaterList[index].video,
                    index: index,
                    isPlayListInfo: true,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
