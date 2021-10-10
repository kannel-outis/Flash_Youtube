import 'dart:io';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/managers/manager.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flash_youtube_downloader/utils/typedef.dart';

class DownloadManager implements IDownloadManager {
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

  DownloadManager({
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
    _cleanPath();
    _output = file.openWrite(mode: FileMode.writeOnlyAppend);
    _audioOutput = audioFile?.openWrite(mode: FileMode.writeOnlyAppend);
  }
  bool _downloadCanceled = false;
  bool _downloadCompleted = false;
  bool _downloadFailed = false;
  bool _downloading = false;

  late final IOSink _output;
  late final IOSink? _audioOutput;
  int downloadedBytes = 0;

  void _cleanPath() {
    if (audioStream != null) {
      if (audioStart == 0 && audioFile!.existsSync()) {
        audioFile!.deleteSync();
      }
    }
    if (start == 0 && file.existsSync()) {
      file.deleteSync();
    }
  }

  Future<void> _closeOutputStreams([bool complete = false]) async {
    if (complete) {
      _downloadCompleted = complete;
    } else {
      _downloadCanceled = true;
    }

    await Future.value([
      _output.flush().then((value) {
        _output.close();
      }),
      _audioOutput?.flush().then((value) {
        _audioOutput?.close();
      }),
    ]).then((value) {
      _downloading = false;
      final totalBytes = downloadedBytes;
      final contentSize = ContentSize(
        bytes: totalBytes,
      );
      if (_downloadCanceled) {
        onCanceledCallback?.call(contentSize, downloadState);
      } else {
        onCompleted?.call(file, audioFile, contentSize, downloadState);
      }
    });
  }

  double get _progress {
    if (audioStream != null) {
      return double.tryParse(((downloadedBytes /
                  stream.combineWithSize(audioStream!.contentSize!).bytes) *
              100)
          .toStringAsFixed(1))!;
    }
    return double.tryParse(((downloadedBytes / stream.contentSize!.bytes) * 100)
        .toStringAsFixed(1))!;
  }

  @override
  Future<bool> downloadStream() async {
    try {
      downloadedBytes = start;
      final bytesStream = Extractor.getStream(stream, start: downloadedBytes);
      _downloading = true;

      /// if downloadedBytes is greater tham or equals to the video bytes
      /// that means that only the audio needs downloading
      /// this is needed for resuming a download either from a failed state or a paused state
      if (downloadedBytes >= stream.contentSize!.bytes) {
        final bytesStream = Extractor.getStream(audioStream!,
            start: downloadedBytes - stream.contentSize!.bytes);

        await for (final data in bytesStream) {
          downloadedBytes += data.length;
          final progress = _progress;
          if (_downloadCanceled) {
            return false;
          }

          downloadProgressCallback?.call("$progress%", downloadState);
          _audioOutput?.add(data);
        }
      } else {
        await for (final data in bytesStream) {
          downloadedBytes += data.length;
          final progress = _progress;
          if (_downloadCanceled) {
            return false;
          }
          downloadProgressCallback?.call("$progress%", downloadState);
          _output.add(data);
        }

        if (audioStream != null) {
          final bytesStream = Extractor.getStream(audioStream!);

          await for (final data in bytesStream) {
            downloadedBytes += data.length;
            final progress = _progress;
            if (_downloadCanceled) {
              return false;
            }

            downloadProgressCallback?.call("$progress%", downloadState);
            _audioOutput?.add(data);
          }
        }
      }

      await _closeOutputStreams(true);
      return true;
    } catch (e) {
      print(e.toString());
      _downloading = false;
      _downloadFailed = true;
      onFailedCallback?.call(e.toString(), downloadState);
      return false;
    }
  }

  @override
  void dispose() {}

  @override
  Future<void> cancelDownload() async {
    await _closeOutputStreams();
  }

  @override
  bool get audioDownload => stream is AudioOnlyStream;

  @override
  bool get videoAudioDownload => audioStream != null;

  @override
  bool get videoDownload =>
      stream is VideoAudioStream || stream is VideoOnlyStream;

  @override
  DownloadState get downloadState {
    if (_downloadCanceled) return DownloadState.canceled;
    if (_downloadCompleted) return DownloadState.completed;
    if (_downloadFailed) return DownloadState.failed;
    if (_downloading) return DownloadState.downloading;
    return DownloadState.notStarted;
  }
}
