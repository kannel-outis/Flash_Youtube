import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/components/circular_progress_indicator.dart';
import 'package:flash_youtube_downloader/components/error_widget.dart';
import 'package:flash_youtube_downloader/screens/downloads/provider/downloads_provider.dart';
import 'package:flash_youtube_downloader/screens/home/providers/home_providers.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/utils/helper.dart';
import 'package:flash_youtube_downloader/utils/scroll_behaviour.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flash_youtube_downloader/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

// int bb = 0;

class ModalSheet extends ConsumerWidget {
  final YoutubeVideo video;
  const ModalSheet({Key? key, required this.video}) : super(key: key);

  static final getContentLengthFutureProvider = FutureProvider.autoDispose
      .family<bool, YoutubeVideoInfo>((ref, video) async {
    return Future.value([
      await Future.forEach<Streams>(
          video.audioOnlyStreams, (element) => element.streamSize),
      await Future.forEach<Streams>(
          video.videoAudioStreams, (element) => element.streamSize),
      await Future.forEach<Streams>(
          video.videoOnlyStreams, (element) => element.streamSize),
    ]).then((value) => true);
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);

    if (video.videoInfo == null) {
      final videoInfo = watch(HomeProviders.videoStateFullInfo(video));
      return videoInfo.when(
        data: (data) {
          return const SizedBox();
        },
        loading: () {
          return Container(
            color: theme.scaffoldBackgroundColor,
            height: 70,
            child: const Center(
              child: CustomCircularProgressIndicator(),
            ),
          );
        },
        error: (obj, stk) {
          return CustomErrorWidget(
            future: HomeProviders.videoStateFullInfo(video),
          );
        },
      );
    }
    final getSizeFuture =
        watch(getContentLengthFutureProvider(video.videoInfo!));
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      height: Utils.blockHeight * 50,
      color: theme.scaffoldBackgroundColor,
      child: getSizeFuture.when(
        data: (data) {
          return Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: Utils.blockWidth * 20,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Utils.containerLabelColor,
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Available Formats",
                    style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: theme.textTheme.bodyText1!.fontSize! + 5,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ScrollConfiguration(
                      behavior: NoEffectScrollConfig(),
                      child: ListView(
                        children: [
                          for (var item in Quality.values)
                            QualityStreams(video: video, item: item)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CustomCircularProgressIndicator(),
        ),
        error: (obj, stack) => CustomErrorWidget(
          autoDisposeFutureProvider:
              getContentLengthFutureProvider(video.videoInfo!),
        ),
      ),
    );
  }
}

class QualityStreams extends ConsumerWidget {
  const QualityStreams({
    Key? key,
    required this.video,
    required this.item,
  }) : super(key: key);

  final YoutubeVideo video;
  final Quality item;

  AudioOnlyStream get getPerfectAudio {
    final listofbitrates =
        video.videoInfo!.audioOnlyStreams.map((e) => e.bitrate).toList();
    final maxBitrate = listofbitrates.reduce((c, n) => c! > n! ? c : n);
    listofbitrates.remove(maxBitrate);
    final perfectAudioBitrate =
        listofbitrates.reduce((c, n) => c! > n! ? c : n)!;
    final perfectAudio = video.videoInfo!.audioOnlyStreams
        .where((element) => element.bitrate == perfectAudioBitrate)
        .first;

    return perfectAudio;
  }

  String videoOnlyDownloadSizeAsString(Streams item) {
    return item.combineWithSize(getPerfectAudio.contentSize!).sizeToString;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final downloadsProvider =
        watch(DownloadsProvider.downloadChangeNotifierProvider);
    return Column(
      children: [
        if (video.videoInfo!.availableQualities.contains(item))
          Container(
            height: Utils.blockHeight * 3,
            width: double.infinity,
            color: isDarkTheme
                ? Utils.containerLabelColor
                : Utils.containerLabelColorLight,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.video_label_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.qualityToString,
                    style: theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox(),
        for (var item in video.videoInfo!.allStreamsOfQuality(item))
          GestureDetector(
            onTap: () async {
              // print(bb);
              // return;

              // Future.delayed(const Duration(seconds: 3), () {
              //   downloader.pauseDownload();
              // });
              // } else {
              //   print("give permission");
              // }
              if (item is VideoAudioStream || item is AudioOnlyStream) {
                final HiveDownloadItem downloadItem = HiveDownloadItem(
                  video: Helper.youtubeVideoHelper(video),
                  streamLinks: [item.url],
                  downloaderId: const Uuid().v4(),
                );
                downloadsProvider.downloadStream(
                  item,
                  video,
                  downloadItem,
                );
              } else if (item is VideoOnlyStream) {
                final HiveDownloadItem downloadItem = HiveDownloadItem(
                  video: Helper.youtubeVideoHelper(video),
                  streamLinks: [item.url, getPerfectAudio.url],
                  downloaderId: const Uuid().v4(),
                );
                downloadsProvider.downloadStream(
                  item,
                  video,
                  downloadItem,
                  audioStream: getPerfectAudio,
                );
              }
            },
            child: Container(
              height: Utils.blockHeight * 5.5,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: item.bitrate == getPerfectAudio.bitrate
                    ? Border.all(
                        color: Utils.containerLabelColorLight, width: 2)
                    : Border.all(width: 0.0, color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    item is AudioOnlyStream
                        ? Icons.audiotrack_outlined
                        : Icons.videocam_outlined,
                  ),
                  Expanded(
                    child: Center(
                      child: (item is! AudioOnlyStream)
                          ? Text(
                              item is VideoOnlyStream
                                  ? "${item.format} (${videoOnlyDownloadSizeAsString(item)})"
                                  : "${item.format} (${item.contentSize!.sizeToString})",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: FontWeight.normal),
                            )
                          : Text(
                              "${item.format} (${item.contentSize!.sizeToString}) - ${item.bitrate.toString().convertToViews(true, false, "kbps")}",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                    ),
                  ),
                  Icon(
                    item is AudioOnlyStream
                        ? Icons.audiotrack_outlined
                        : Icons.videocam_outlined,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
