import 'dart:io';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/managers/download_manager.dart';
import 'package:flash_youtube_downloader/services/managers/manager.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flash_youtube_downloader/utils/typedef.dart';

class Downloader extends ManagerHandler<IDownloadManager> {
  final File file;
  final File? audioFile;
  final Streams stream;
  final Streams? audioStream;
  final DownloadCompletedCallback? onCompleted;
  final DownloadProgressCallback? downloadProgressCallback;
  final int start;
  final int audioStart;
  final DownloadCancelCallback? onCanceledCallback;
  final DownloadFailedCallback? onFailedCallback;

  Downloader({
    required this.file,
    required this.stream,
    this.audioFile,
    this.audioStream,
    this.onCanceledCallback,
    this.start = 0,
    this.audioStart = 0,
    this.onCompleted,
    this.downloadProgressCallback,
    this.onFailedCallback,
  }) {
    final newManager = DownloadManager(
      file: file,
      stream: stream,
      start: start,
      audioStart: audioStart,
      audioFile: audioFile,
      audioStream: audioStream,
      downloadProgressCallback: downloadProgressCallback,
      onCanceledCallback: onCanceledCallback,
      onCompleted: onCompleted,
      onFailedCallback: onFailedCallback,
    );
    setManager(newManager);
  }

  @override
  Manager? setManager(IDownloadManager? newManager) {
    return super.setManager(newManager);
  }

  Future<bool> downloadStream() async {
    return manager!.downloadStream();
  }

  Future<void> cancelDownload() async {
    await manager!.cancelDownload();
  }

  bool get videoDownload => manager!.videoDownload;
  bool get audioDownload => manager!.audioDownload;
  bool get videoAudioDownload => manager!.videoAudioDownload;
  DownloadState get downloadState => manager!.downloadState;
}



//  print(item.contentSize!.sizeToString);
//               final permission = await PermissionHandler.requestPermission();
//               if (permission == true) {
//                 final dir = await getExternalStorageDirectory();
//                 final knockDir = await Directory('${dir!.path}/downloader/')
//                     .create(recursive: true);
//                 final file =
//                     File("${knockDir.path}${"testing.${item.format}"}");
//                 final audioFile = File(
//                     "${knockDir.path}${"testinga.${getPerfectAudio.format}"}");
//                 final downloader = Downloader(
//                     file: file,
//                     stream: item,
//                     audioFile: audioFile,
//                     audioStream: getPerfectAudio,
//                     downloadProgressCallback: (c) {
//                       print(c);
//                     },
//                     onFailedCallback: (e) {
//                       print(e + "6");
//                     },
//                     onCompleted: (e, r, t) {
//                       print(e.path);
//                       print(r?.path);
//                       print(t.sizeToString);
//                     });
//                 downloader.downloadStream();
//               } else {
//                 print("give permission");
//               }
