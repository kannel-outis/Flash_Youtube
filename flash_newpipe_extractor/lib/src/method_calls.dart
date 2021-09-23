import 'dart:async';
import 'package:flash_newpipe_extractor/src/error/error.dart';
import 'package:flash_newpipe_extractor/src/models/channel.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comments.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comment_info.dart';
import 'package:flash_newpipe_extractor/src/models/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';
import 'package:flash_newpipe_extractor/src/models/stream/audioOnlyStream.dart';
import 'package:flash_newpipe_extractor/src/models/stream/videoAudioStream.dart';
import 'package:flash_newpipe_extractor/src/models/stream/videoOnlyStream.dart';
import 'package:flash_newpipe_extractor/src/models/videoInfo.dart';
import 'package:flutter/services.dart';

import 'models/video.dart';
import 'utils/utils.dart';

class FlashMethodCalls {
  static const MethodChannel _channel =
      const MethodChannel('flash_newPipe_extractor');

  static Future<List<YoutubeVideo>?> getTrendingVideos() async {
    try {
      List<YoutubeVideo> _listOfVideo = [];
      final result = await _channel.invokeMethod('getTrending');

      final resultMap = Utils.convertToMapType(result);
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
    final Map<String, Map<int, Map<String, dynamic>>> resultMap =
        Utils.convertToType(result);
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

    resultMap["relatedVideos"]!.forEach((key, value) {
      final video = YoutubeVideo.fromMap(value);
      fullinfo.addRelatedVideo(video);
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
    if (result["channelInfo"] == null) {
      throw FlashException("Content Not Available");
    }
    final Map<String, Map<int, Map<String, dynamic>>> _resultMap =
        Utils.convertToType(result);

    final channel = Channel.fromMap(_resultMap["channelInfo"]![0]!);
    channel.setPage =
        Page.fromMap(Map.from(_resultMap["channelInfo"]![0]!["nextPageInfo"]));
    _resultMap["channelFirstPageVideos"]!.forEach((key, value) {
      channel.addToGrowableList(YoutubeVideo.fromMap(value));
    });
    return channel;
  }

  /// commemts

  static Future<Comments> getvideoComments(String url) async {
    final result = await _channel.invokeMethod("getComments", {"url": url});
    final _resultMap = Utils.convertToMapType(result);
    final List<CommentInfo> _commentsInfolist = [];
    if (_resultMap.containsKey(200)) {
      return Comments(isDisabled: true);
    } else {
      _resultMap.forEach((key, value) {
        final commentInfo = CommentInfo.fromMap(value);
        _commentsInfolist.add(commentInfo);
      });
      return Comments(isDisabled: false, comments: _commentsInfolist);
    }
  }

  // next page

  static Future<void> getItemsNextPage(GrowablePageList manager) async {
    final _manager = manager;
    final result = await _channel.invokeMethod(
      "getChannelNextPageItems",
      {
        // change url to optional
        "channelUrl": _manager.childPage!.ids![1],
        "pageInfo": _manager.childPage!.toMap(),
      },
    );
    final Map<String, Map<int, Map<String, dynamic>>> _resultMap =
        Utils.convertToType(result);
    final _page =
        Page.fromMap(Map.from(_resultMap["page"]![0]!["newPageInfo"]));
    _manager.child.setPage = _page;
    _resultMap["items"]!.forEach((key, value) {
      _manager.addToGrowableList(YoutubeVideo.fromMap(value));
    });
  }
}
