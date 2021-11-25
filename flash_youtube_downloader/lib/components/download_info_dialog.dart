import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flash_youtube_downloader/utils/extensions.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class DownlaodInfoDialog extends StatelessWidget {
  final HiveDownloadItem item;
  const DownlaodInfoDialog({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1?.copyWith(
      fontWeight: FontWeight.normal,
    );
    return Builder(builder: (context) {
      return Dialog(
        child: Container(
          height: Utils.blockHeight * 50,
          width: Utils.blockWidth * 85,
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                width: 400,
                height: 250,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: item.video.thumbnailUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Name :   ${item.video.name}",
                          style: textStyle,
                        ),
                        const _Spacer(),
                        ItemItem(
                            label: "Different Audio File",
                            sub: item.downloadPaths[1] != null
                                ? "True"
                                : "False"),
                        const _Spacer(),
                        ItemItem(
                          label: "Download State",
                          sub: item.downloadState.convertStateToString,
                          style: textStyle!.copyWith(
                            color: stateTextColor,
                          ),
                        ),
                        const _Spacer(),
                        Text(
                          "Downloaded Audio Path: ${item.downloadPaths[1] ?? "null"}",
                          style: textStyle,
                        ),
                        const _Spacer(),
                        Text(
                          "Downloaded Video Path: ${item.downloadPaths[0] ?? "null"}",
                          style: textStyle,
                        ),
                        const _Spacer(),
                        ItemItem(
                          label: "Download Size",
                          sub: Utils.bytesToContentSize(item.downloadedBytes)
                              .sizeToString,
                          style: textStyle.copyWith(color: stateTextColor),
                        ),
                        const _Spacer(),
                        ItemItem(
                          label: "Actual Size",
                          sub: Utils.bytesToContentSize(item.totalSize)
                              .sizeToString,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Color get stateTextColor {
    switch (item.downloadState) {
      case DownloadState.downloading:
        return Colors.lightBlue;
      case DownloadState.canceled:
        return Colors.grey;
      case DownloadState.paused:
        return Colors.yellow;
      case DownloadState.failed:
        return Colors.red;
      case DownloadState.completed:
        return Colors.green;
      case DownloadState.notStarted:
        return Colors.blue;
      default:
        return Colors.white;
    }
  }
}

class ItemItem extends StatelessWidget {
  final String label;
  final String sub;
  final TextStyle? style;
  const ItemItem({Key? key, required this.label, required this.sub, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1?.copyWith(
      fontWeight: FontWeight.normal,
    );
    return Row(
      children: [
        Text(
          "$label :   ",
          style: textStyle,
        ),
        Text(
          sub,
          style: style ?? textStyle,
        ),
      ],
    );
  }
}

class _Spacer extends StatelessWidget {
  const _Spacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}
