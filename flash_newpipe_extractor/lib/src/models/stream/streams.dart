import 'package:flash_newpipe_extractor/src/utils/content_length.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';

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
    final kb = totalBytes / 1024;
    final mb = kb / 1024;
    final gb = mb / 1024;
    return ContentSize(
      bytes: totalBytes,
      kiloBytes: kb,
      megaBytes: mb,
      gigaBytes: gb,
    );
  }

  Future<ContentSize> get streamSize async {
    return _size = _size ?? await ContentLength.getStreamSize(this);
  }
}
