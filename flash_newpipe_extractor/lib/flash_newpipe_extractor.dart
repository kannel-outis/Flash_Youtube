import 'dart:async';
import 'dart:developer';

import 'package:flash_newpipe_extractor/models/videoInfo.dart';
import 'package:flutter/services.dart';

class FlashNewpipeExtractor {
  static const MethodChannel _channel =
      const MethodChannel('flash_newPipe_extractor');

  static Future<List<YoutubeVideo>> getTrendingVideos() async {
    var s = await _channel.invokeMethod('getTrending');
    log("$s");
  }
}
