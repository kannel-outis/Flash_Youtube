import 'dart:io';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/offline/hive/hive_handler.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/services/online/handler/download_handler.dart';
import 'package:flash_youtube_downloader/utils/permission.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

//ignore_for_file: avoid_print

class DownloadChangeNotifier extends ChangeNotifier {
  final hiveHandler = HiveHandler();
  // ignore: prefer_final_fields
  List<Downloader> _listOfCurrentDownloaders = <Downloader>[];

  Downloader _getDownloader(String id) {
    return _listOfCurrentDownloaders
        .where((element) => element.downloaderId == id)
        .first;
  }

  void deleteAllEntries() {
    hiveHandler.deleteAllDownloadsFromHistory();
  }

  bool _downloaderListContainsDownloader(String id) {
    final single = _listOfCurrentDownloaders
        .where((element) => element.downloaderId == id);
    if (single.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> pauseDownload(HiveDownloadItem downloadItem) async {
    final downloader = _getDownloader(downloadItem.downloaderId);
    await downloader.pauseDownload();
  }

  Future<void> cancelDownload(
    HiveDownloadItem downloadItem,
  ) async {
    late final Downloader downloader;
    if (!_downloaderListContainsDownloader(downloadItem.downloaderId)) {
      final whichStream = _whichMainStreamToDownload(
        downloadItem.videoAudioStream,
        downloadItem.audioOnlyStream,
        downloadItem.videoOnlyStream,
      )!;
      downloader = Downloader(
        downloaderId: downloadItem.downloaderId,
        file: File(downloadItem.downloadPaths[0]!),
        stream: whichStream,
        start: downloadItem.downloadedBytes,
        audioFile: downloadItem.downloadPaths[1] != null
            ? File(downloadItem.downloadPaths[1]!)
            : null,
        audioStream: downloadItem.audioOnlyStream,
        onCanceledCallback: (size, state) {
          downloadItem.downloadState = state;
          downloadItem.save();
        },
      );
    } else {
      downloader = _getDownloader(downloadItem.downloaderId);
    }
    await downloader.cancelDownload();
  }

  void _onDownloadCompleted(HiveDownloadItem downloadItem) {
    final downloader = _getDownloader(downloadItem.downloaderId);
    _listOfCurrentDownloaders.remove(downloader);
  }

  Future<void> downloadStream(
    YoutubeVideo video,
    HiveDownloadItem downloadItem, {
    AudioOnlyStream? audioStream,
    bool continueDownload = false,
  }) async {
    if (!continueDownload) await hiveHandler.saveNewDownloadItem(downloadItem);
    final whichStream = _whichMainStreamToDownload(
      downloadItem.videoAudioStream,
      downloadItem.audioOnlyStream,
      downloadItem.videoOnlyStream,
    )!;
    final permission = await PermissionHandler.requestPermission();
    if (whichStream.contentSize == null) {
      await Future.value([
        await whichStream.streamSize,
        await audioStream?.streamSize,
      ]);
    }
    if (permission == true) {
      final dir = await getExternalStorageDirectory();
      final knockDir =
          await Directory('${dir!.path}/downloader/${video.videoName}/')
              .create(recursive: true);
      final file = File(
        "${knockDir.path}${video.videoName}${whichStream.contentSize!.bytes}.${whichStream.format}",
      );
      final audioFile = audioStream == null
          ? null
          : File(
              "${knockDir.path}${video.videoName}${audioStream.contentSize!.bytes}.${audioStream.format}",
            );

      downloadItem.downloadPaths = [file.path, audioFile?.path];
      downloadItem.save();
      final downloader = Downloader(
        downloaderId: downloadItem.downloaderId,
        file: file,
        stream: whichStream,
        start: downloadItem.downloadedBytes,
        audioFile: audioFile,
        audioStream: audioStream,
        downloadProgressCallback: (size, progress, state) {
          downloadItem.downloadedBytes = size.bytes;
          downloadItem.progress = progress;
          downloadItem.downloadState = state;
          downloadItem.save();
        },
        onFailedCallback: (message, state) {
          print("$message 6");
          downloadItem.downloadState = state;
          downloadItem.save();
        },
        onCanceledCallback: (size, state) {
          downloadItem.downloadedBytes = size.bytes;
          downloadItem.downloadState = state;
          downloadItem.save();
          print(size.sizeToString);
          print(state);
        },
        onCompleted: (videoFile, audioFile, size, state) {
          print(videoFile.path);
          print(audioFile?.path);
          print(size.sizeToString);
          downloadItem.downloadedBytes = size.bytes;
          downloadItem.downloadState = state;
          downloadItem.downloadPaths = [videoFile.path, audioFile?.path];
          _onDownloadCompleted(downloadItem);
          downloadItem.save();
        },
      );
      _listOfCurrentDownloaders = List.from(_listOfCurrentDownloaders)
        ..add(downloader);
      downloader.downloadStream();
    }
  }

  Streams? _whichMainStreamToDownload(
    VideoAudioStream? videoAudioStream,
    AudioOnlyStream? audioOnlyStream,
    VideoOnlyStream? videoOnlyStream,
  ) {
    if (audioOnlyStream == null && videoOnlyStream == null) {
      return videoAudioStream;
    } else if (videoAudioStream == null && videoOnlyStream != null) {
      return videoOnlyStream;
    } else if (videoOnlyStream == null && videoAudioStream == null) {
      return audioOnlyStream;
    }
  }
}
