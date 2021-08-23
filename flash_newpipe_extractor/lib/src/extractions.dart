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
}
