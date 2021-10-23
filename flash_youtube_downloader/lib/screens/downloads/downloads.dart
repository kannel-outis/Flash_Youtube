import 'package:flash_youtube_downloader/components/video/video_info_tile_.dart';
import 'package:flash_youtube_downloader/screens/downloads/provider/downloads_provider.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final downloadsProvider =
        watch(DownloadsProvider.downloadChangeNotifierProvider);
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        title: Text(
          "Downloads",
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(50, 40),
            onSelected: (value) {
              if (value == "Delete All") {
                downloadsProvider.deleteAllEntries();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<String>(
                  value: "Delete All",
                  child: Text("Delete from history"),
                ),
              ];
            },
            child: const SizedBox(
              width: 40,
              height: 30,
              child: Center(
                child: Icon(Icons.more_vert, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<HiveDownloadItem>>(
        valueListenable:
            Hive.box<HiveDownloadItem>(HiveInit.hiveDownloadItems).listenable(),
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
              return Column(
                children: [
                  if (index == 0) const SizedBox(height: 20),
                  VideoInfoTile(
                    video: items[index].video,
                    isDownloadTile: true,
                    item: items[index],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
