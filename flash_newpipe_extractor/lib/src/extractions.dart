import 'package:flash_newpipe_extractor/src/models/channel.dart';
import 'package:flash_newpipe_extractor/src/models/comment/comments.dart';

import 'method_calls.dart';
import 'models/video.dart';
import 'models/videoInfo.dart';

class Extract {
  Future<List<YoutubeVideo>?> getTrendingVideos() async {
    return FlashMethodCalls.getTrendingVideos();
  }

  Future<YoutubeVideoInfo> getVideoInfoFromUrl(String url) async {
    return await FlashMethodCalls.getVideoInfoFromUrl(url);
  }

  Future<Channel> getChannelInfo(String channelUrl) async {
    return await FlashMethodCalls.getChannelInfo(channelUrl);
  }

  Future<Comments> getComments(String url) async {
    return await FlashMethodCalls.getvideoComments(url);
  }
}
