import 'dart:async';
import 'package:flash_newpipe_extractor/src/models/channel.dart';
import 'package:flash_newpipe_extractor/src/models/stream/audioOnlyStream.dart';
import 'package:flash_newpipe_extractor/src/models/stream/videoAudioStream.dart';
import 'package:flash_newpipe_extractor/src/models/stream/videoOnlyStream.dart';
import 'package:flash_newpipe_extractor/src/models/videoInfo.dart';
import 'package:flutter/services.dart';

import 'models/video.dart';

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

  static Future<YoutubeVideoInfo> getVideoInfoFromUrl(String url) async {
    final result = await _channel.invokeMethod(
      "getVideoInfoFromUrl",
      {
        "url": url,
      },
    );
    final resultMap = Map<String, dynamic>.from(result).map(
      (key, value) => MapEntry(
        key,
        Map<int, dynamic>.from(value).map(
          (key, value) => MapEntry(
            key,
            Map<String, dynamic>.from(value),
          ),
        ),
      ),
    );
    final fullinfo = YoutubeVideoInfo.fromMap(resultMap["fullVideoInfo"]![0]!);
    resultMap["audioStreamsMap"]!.forEach((key, value) {
      final stream = AudioOnlyStream.fromMap(value);
      fullinfo.addAudioOnlyStream(stream);
    });

    resultMap["videoOnlyStream"]!.forEach((key, value) {
      final stream = VideoOnlyStream.fromMap(value);
      fullinfo.addVideoOnlyStream(stream);
    });

    resultMap["videoAudioStream"]!.forEach((key, value) {
      final stream = VideoAudioStream.fromMap(value);
      fullinfo.addVideoAudioStream(stream);
    });
    return fullinfo;
  }

  static Future<Channel> getChannelInfo(String channelUrl) async {
    final result = await _channel.invokeMethod(
      "getChannelInfo",
      {
        "channelUrl": channelUrl,
      },
    );
    final _resultMap = Map<String, dynamic>.from(result).map(
      (key, value) => MapEntry(
        key,
        Map<int, dynamic>.from(value).map(
          (key, value) => MapEntry(
            key,
            Map<String, dynamic>.from(value),
          ),
        ),
      ),
    );

    final channel = Channel.fromMap(_resultMap["channelInfo"]![0]!);
    _resultMap["channelFirstPageVideos"]!.forEach((key, value) {
      channel.addToVideoList(YoutubeVideo.fromMap(value));
    });
    return channel;
  }
}
