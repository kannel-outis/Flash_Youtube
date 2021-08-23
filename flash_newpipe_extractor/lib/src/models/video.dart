import 'package:flash_newpipe_extractor/src/method_calls.dart';
import 'package:flash_newpipe_extractor/src/models/videoInfo.dart';

import '../utils/utils.dart';

class YoutubeVideo {
  final String? videoName;
  final String url;
  final int? viewCount;
  final String? textualUploadDate;
  final String? uploaderName;
  final String? uploaderUrl;
  final String? thumbnailUrl;
  final Duration? duration;
  final DateTime? uploadDate;
  final bool? isUploaderVerified;

  const YoutubeVideo({
    this.videoName,
    required this.url,
    this.viewCount,
    this.textualUploadDate,
    this.uploaderName,
    this.uploaderUrl,
    this.thumbnailUrl,
    this.duration,
    this.uploadDate,
    this.isUploaderVerified,
  });

  Future<YoutubeVideoInfo> get getFullInformation async {
    return await FlashMethodCalls.getVideoInfoFromUrl(url);
  }

  factory YoutubeVideo.fromMap(Map<String, dynamic> map) {
    return YoutubeVideo(
      url: map["url"],
      uploaderUrl: map["uploaderUrl"],
      isUploaderVerified: map["isUploaderVerified"],
      textualUploadDate: map["textualUploadDate"],
      uploadDate: DateTime.tryParse(
        Utils.retrieveTime(
          map["textualUploadDate"],
        ),
      ),
      duration: Duration(seconds: map["duration"]),
      thumbnailUrl: map["thumbnailUrl"],
      uploaderName: map["uploaderName"],
      videoName: map["videoName"],
      viewCount: map["viewCount"],
    );
  }
}
