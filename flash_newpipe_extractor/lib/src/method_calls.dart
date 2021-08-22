import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

import 'models/videoInfo.dart';

class FlashMethodCalls {
  static const MethodChannel _channel =
      const MethodChannel('flash_newPipe_extractor');

  static Future<List<YoutubeVideo>?> getTrendingVideos() async {
    try {
      List<YoutubeVideo> _listOfVideo = [];
      final result = await _channel.invokeMethod('getTrending');

      final resultMap = Map<int, dynamic>.from(result)
          .map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
      resultMap.forEach((key, value) {
        final yVideo = YoutubeVideo.fromMap(value);
        _listOfVideo.add(yVideo);
      });
      return _listOfVideo;
    } catch (e) {
      return null;
    }
  }

  static Future<void> getVideoInfoFromUrl(String url) async {
    final result = await _channel.invokeMethod("getVideoInfoFromUrl", {
      "url": url,
    });
    log(result.toString());
  }
}
