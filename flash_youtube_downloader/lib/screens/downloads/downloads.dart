import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloads"),
      ),
      body: ValueListenableBuilder<Box<HiveDownloadItem>>(
          valueListenable:
              Hive.box<HiveDownloadItem>(HiveInit.hiveDownloadItems)
                  .listenable(),
          builder: (context, box, child) {
            final items = box.values.toList().reversed.toList();
            if (items.isEmpty) {
              return SizedBox(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 150,
                        color: Colors.grey.withOpacity(.5),
                      ),
                      Text(
                        "No Downloads. Explore videos and save offline.",
                        style: theme.textTheme.headline6!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                // return Text(items[index].progress);
                return VideoInfoTile(
                  video: items[index].video,
                  isDownloadTile: true,
                  item: items[index],
                );
              },
            );
          }),
    );
  }
}
