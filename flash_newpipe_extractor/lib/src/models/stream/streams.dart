import 'dart:io';

import 'package:flash_newpipe_extractor/src/services/extractor.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';

import '../content_size.dart';

abstract class Streams {
  final String url;
  final String? codec;
  final String? torrentUrl;
  final int? bitrate;
  final int? iTag;
  final String format;
  final Quality quality;

  Streams({
    required this.url,
    this.codec,
    this.torrentUrl,
    this.bitrate,
    this.iTag,
    required this.format,
    required this.quality,
  });

  ContentSize? _size;

  ContentSize? get contentSize => _size;

  ContentSize combineSizes(ContentSize sizeOne, ContentSize sizeTwo) {
    final totalBytes = sizeOne.bytes + sizeTwo.bytes;
    return ContentSize(
      bytes: totalBytes,
    );
  }

  Future<ContentSize> get streamSize async {
    return _size = _size ?? await Extractor.getStreamSize(this);
  }

  Future<bool> downloadStream(File file,
      {Function(File, ContentSize)? onCompleted,
      Function(String)? progressCallBack,
      int start = 0}) async {
    try {
      int downloadedBytes = start;
      final stream = Extractor.getStream(this, start: start);
      if (start == 0 && file.existsSync()) {
        file.deleteSync();
      }
      var output = file.openWrite(mode: FileMode.writeOnlyAppend);
      await for (var data in stream) {
        downloadedBytes += data.length;
        final progress =
            ((downloadedBytes / _size!.bytes) * 100).ceilToDouble();
        progressCallBack?.call("$progress%");
        output.add(data);
      }
      await output.flush().then(
            (value) => output.close().then(
              (value) {
                final totalBytes = downloadedBytes;
                final contentSize = ContentSize(
                  bytes: totalBytes,
                );

                onCompleted?.call(file, contentSize);
              },
            ),
          );
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
