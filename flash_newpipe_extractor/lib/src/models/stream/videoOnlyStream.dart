import 'dart:ui';
import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';
import '../../utils/extensions.dart';

class VideoOnlyStream extends Streams {
  final String url;
  final String? codec;
  final String? torrentUrl;
  final int? bitrate;
  final int? iTag;
  final String format;
  final Quality quality;
  final int fps;
  final String resolution;
  final double height;
  final double width;
  final bool isVideoOnly;

  VideoOnlyStream(
    this.url,
    this.codec,
    this.torrentUrl,
    this.bitrate,
    this.iTag,
    this.format,
    this.quality,
    this.fps,
    this.resolution,
    this.height,
    this.width,
    this.isVideoOnly,
  ) : super(
          url: url,
          quality: quality,
          format: format,
          bitrate: bitrate,
          codec: codec,
          iTag: iTag,
          torrentUrl: torrentUrl,
        );

  Size get size => Size(width, height);
  double get aspectRatio => width / height;

  factory VideoOnlyStream.fromMap(Map<String, dynamic> map) {
    return VideoOnlyStream(
      map["url"],
      map["codec"],
      map["torrentUrl"],
      map["bitrate"],
      map["iTag"],
      map["format"],
      (map["quality"] as String).toQuality,
      map["fps"],
      map["resolution"],
      (map["height"] as int).toDouble(),
      (map["width"] as int).toDouble(),
      map["isVideoOnly"],
    );
  }
}
