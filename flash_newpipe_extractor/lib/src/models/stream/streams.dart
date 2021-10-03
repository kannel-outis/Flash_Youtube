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

  String? _size;

  String? get downloadSize => _size;

  Future<String> get streamSize async {
    return _size = _size ?? await ContentLength.getStreamSize(this);
  }
}
