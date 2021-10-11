import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<Box<HiveDownloadItem>>(
          valueListenable:
              Hive.box<HiveDownloadItem>(HiveInit.hiveDownloadItems)
                  .listenable(),
          builder: (context, box, child) {
            final items = box.values.toList();
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                return Text(items[index].progress);
              },
            );
          }),
    );
  }
}
