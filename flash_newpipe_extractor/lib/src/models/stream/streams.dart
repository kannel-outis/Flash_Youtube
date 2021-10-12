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
  final StreamFormat streamFormat;

  Streams({
    required this.url,
    this.codec,
    this.torrentUrl,
    this.bitrate,
    this.iTag,
    required this.format,
    required this.quality,
    required this.streamFormat,
  });

  ContentSize? _size;

  ContentSize? get contentSize => _size;

  ContentSize combineWithSize(ContentSize contentSize) {
    assert(this.contentSize != null,
        "content size is still null. you should call stream size before proceeding.");
    final totalBytes = this.contentSize!.bytes + contentSize.bytes;
    return ContentSize(
      bytes: totalBytes,
    );
  }

  Future<ContentSize> get streamSize async {
    return _size = _size ?? await Extractor.getStreamSize(this);
  }
}
