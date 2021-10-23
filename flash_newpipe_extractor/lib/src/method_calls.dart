import 'dart:async';
import 'dart:developer';

import 'package:flash_newpipe_extractor/src/error/error.dart';
import 'package:flash_newpipe_extractor/src/models/channel/channel.dart';
import 'package:flash_newpipe_extractor/src/models/channel/channel_info.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comment_info.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comments.dart';
import 'package:flash_newpipe_extractor/src/models/info_item.dart';
import 'package:flash_newpipe_extractor/src/models/page/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';
import 'package:flash_newpipe_extractor/src/models/playlist/playlist.dart';
import 'package:flash_newpipe_extractor/src/models/playlist/playlist_info.dart';
import 'package:flash_newpipe_extractor/src/models/stream/audioOnlyStream.dart';
import 'package:flash_newpipe_extractor/src/models/stream/videoAudioStream.dart';
import 'package:flash_newpipe_extractor/src/models/stream/videoOnlyStream.dart';
import 'package:flash_newpipe_extractor/src/models/video/videoInfo.dart';
import 'package:flutter/services.dart';

import 'models/search/search.dart';
import 'models/video/video.dart';
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
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  static Future<YoutubeVideoInfo> getVideoInfoFromUrl(String url) async {
    try {
      final result = await _channel.invokeMethod(
        "getVideoInfoFromUrl",
        {
          "url": url,
        },
      );
      final Map<String, Map<int, Map<String, dynamic>>> resultMap =
          Utils.convertToType(result);
      final fullinfo =
          YoutubeVideoInfo.fromMap(resultMap["fullVideoInfo"]![0]!);
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
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  static Future<ChannelInfo> getChannelInfo(String channelUrl) async {
    try {
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

      final channel = ChannelInfo.fromMap(_resultMap["channelInfo"]![0]!);
      channel.setPage = Page.fromMap(
          Map.from(_resultMap["channelInfo"]![0]!["nextPageInfo"]));
      _resultMap["channelFirstPageVideos"]!.forEach((key, value) {
        channel.addToGrowableList(YoutubeVideo.fromMap(value));
      });
      return channel;
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  /// commemts

  static Future<Comments> getvideoComments(String url) async {
    try {
      final result = await _channel.invokeMethod("getComments", {"url": url});
      final _resultMap = Utils.convertToMapType(result);
      final comments = Comments(
          isDisabled: _resultMap.containsKey(20000) ? true : false, url: url);
      _resultMap.forEach((key, value) {
        final commentInfo = CommentInfo.fromMap(value);
        comments.addToGrowableList(commentInfo);
      });
      comments.setPage = Page.fromMap(Map.from(_resultMap[20001]!));
      return comments;
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  // next page

  static Future<void> getItemsNextPage(GrowablePage growablePage) async {
    try {
      final _growable = growablePage;
      final result = await _channel.invokeMethod(
        "getChannelNextPageItems",
        {
          "Type": _growable.type,
          "value": _growable.manager.value,
          "pageInfo": _growable.manager.page!.toMap(),
        },
      );
      final Map<String, Map<int, Map<String, dynamic>>> _resultMap =
          Utils.convertToType(result);
      final _page =
          Page.fromMap(Map.from(_resultMap["page"]![0]!["newPageInfo"]))
              .copyWith(pageNumber: _growable.manager.page!.pageNumber);
      _growable.manager.setPage = _page;
      _resultMap["items"]!.forEach(
        (key, value) {
          InfoItem _item;
          if (_growable.type == "searches") {
            if (value.containsKey("channelUrl")) {
              _item = Channel.fromMap(value);
            } else if (value.containsKey("playListUrl")) {
              _item = Playlist.fromMap(value);
            } else {
              _item = YoutubeVideo.fromMap(value);
            }
          } else {
            _item = YoutubeVideo.fromMap(value);
          }
          _growable.addToGrowableList(_growable.type == "comments"
              ? CommentInfo.fromMap(value)
              : _item);
        },
      );
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  // search

  static Future<List<String>> getSearchSuggestions(String query) async {
    try {
      final result = await _channel.invokeMethod("getSearchSuggestions", {
        "query": query,
      });
      return List<String>.from(result);
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  static Future<Search> getSearchResults(String query) async {
    try {
      final result =
          await _channel.invokeMethod("getSearchResults", {"query": query});
      final _resultMap = Map<String, dynamic>.from(result);
      final search = Search.fromMap(_resultMap);
      final _page =
          Page.fromMap(Map<String, dynamic>.from(_resultMap["nextPageInfo"]));
      final _videoMap = Map<int, dynamic>.from(_resultMap["results"])
          .map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
      _videoMap.forEach((key, value) {
        InfoItem _item;
        if (value.containsKey("channelUrl")) {
          _item = Channel.fromMap(value);
        } else if (value.containsKey("playListUrl")) {
          _item = Playlist.fromMap(value);
        } else {
          _item = YoutubeVideo.fromMap(value);
        }
        search.addToGrowableList(_item);
      });
      search.setPage = _page;
      return search;
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }

  //playlist info
  static Future<PlaylistInfo> getPlaylistInfo(String url) async {
    try {
      final result =
          await _channel.invokeMethod("getPlaylistInfo", {"url": url});
      if (result["playlistInfo"] == null) {
        throw FlashException("Content Not Available");
      }
      final Map<String, Map<int, Map<String, dynamic>>> _resultMap =
          Utils.convertToType(result);

      final playlistInfo =
          PlaylistInfo.fromMap(_resultMap["playlistInfo"]![0]!);
      playlistInfo.setPage = Page.fromMap(
          Map.from(_resultMap["playlistInfo"]![0]!["nextPageInfo"]));
      _resultMap["videoItems"]!.forEach((key, value) {
        playlistInfo.addToGrowableList(YoutubeVideo.fromMap(value));
      });
      return playlistInfo;
    } on PlatformException catch (e) {
      throw FlashException(e.message ?? e.code);
    }
  }
}
