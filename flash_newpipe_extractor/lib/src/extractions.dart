import 'package:flash_newpipe_extractor/src/models/channel/channel_info.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comments.dart';

import 'method_calls.dart';
import 'models/video/video.dart';
import 'models/video/videoInfo.dart';

class Extract {
  Future<List<YoutubeVideo>?> getTrendingVideos() async {
    return FlashMethodCalls.getTrendingVideos();
  }

  Future<YoutubeVideoInfo> getVideoInfoFromUrl(String url) async {
    return await FlashMethodCalls.getVideoInfoFromUrl(url);
  }

  Future<ChannelInfo> getChannelInfo(String channelUrl) async {
    return await FlashMethodCalls.getChannelInfo(channelUrl);
  }

  Future<Comments> getComments(String url) async {
    return await FlashMethodCalls.getvideoComments(url);
  }

  Future<List<String>> getSearchSuggestions(String query) async {
    return await FlashMethodCalls.getSearchSuggestions(query);
  }

  Future<void> getSearchResults(String query) async {
    await FlashMethodCalls.getSearchResults(query);
  }
}
