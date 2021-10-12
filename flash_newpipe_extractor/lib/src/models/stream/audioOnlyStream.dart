import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';
import '../../utils/extensions.dart';

class AudioOnlyStream extends Streams {
  final String url;
  final String? codec;
  final String? torrentUrl;
  final int? bitrate;
  final int? avergaeBitrate;
  final int? iTag;
  final String format;
  final Quality quality;
  AudioOnlyStream(
    this.url,
    this.codec,
    this.torrentUrl,
    this.bitrate,
    this.avergaeBitrate,
    this.iTag,
    this.format,
    this.quality,
  ) : super(
          url: url,
          quality: quality,
          format: format,
          bitrate: bitrate,
          codec: codec,
          iTag: iTag,
          torrentUrl: torrentUrl,
          streamFormat: format.asStreamFormat,
        );

  factory AudioOnlyStream.fromMap(Map<String, dynamic> map) {
    return AudioOnlyStream(
      map["url"],
      map["codec"],
      map["torrentUrl"],
      map["bitrate"],
      map["avergaeBitrate"],
      map["iTag"],
      map["format"],
      (map["quality"] as String).toQuality,
    );
  }
}
