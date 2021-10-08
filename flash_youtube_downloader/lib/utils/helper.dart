import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_youtube_video.dart';

class Helper {
  static HiveYoutubeVideo youtubeVideoHelper(YoutubeVideo video) {
    return HiveYoutubeVideo(
      videoUrl: video.url,
      thumbnailurl: video.thumbnailUrl,
      uploadDateText: video.textualUploadDate,
      uploaddate: video.uploadDate,
      uploadername: video.uploaderName,
      uploaderurl: video.uploaderUrl,
      videoDuration: video.duration!.inMilliseconds,
      videoname: video.name,
      views: video.viewCount,
    );
  }
}
