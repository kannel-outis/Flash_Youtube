import 'package:flash_newpipe_extractor/src/method_calls.dart';
import 'package:flash_newpipe_extractor/src/models/video/videoInfo.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';

import '../../utils/utils.dart';
import '../channel/channel_info.dart';
import '../info_item.dart';

class YoutubeVideo extends InfoItem {
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

  YoutubeVideo({
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
  }) : super(
            name: videoName!,
            avatarThumbnailUrl: thumbnailUrl!,
            type: InfoType.VIDEO,
            url: url);
  String get id => Utils.getIdFromUrl(url);

  YoutubeVideoInfo? _videoInfo;
  YoutubeVideoInfo? get videoInfo => _videoInfo;

  Future<YoutubeVideoInfo> get getFullInformation async {
    return _videoInfo = await FlashMethodCalls.getVideoInfoFromUrl(url);
  }

  String get hqdefault => "https://img.youtube.com/vi/$id/hqdefault.jpg";

  String get mqdefault => "https://img.youtube.com/vi/$id/mqdefault.jpg";

  String get sddefault => "https://img.youtube.com/vi/$id/sddefault.jpg";

  String get maxresdefault =>
      "https://img.youtube.com/vi/$id/maxresdefault.jpg";

  ChannelInfo? _uploaderChannel;
  ChannelInfo? get uploaderChannelInfo => _uploaderChannel;
  Future<ChannelInfo?> getUploaderChannelInfo() async {
    try {
      return _uploaderChannel =
          await FlashMethodCalls.getChannelInfo(uploaderUrl!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  factory YoutubeVideo.fromMap(Map<String, dynamic> map) {
    return YoutubeVideo(
      url: map["url"],
      uploaderUrl: map["uploaderUrl"],
      isUploaderVerified: map["isUploaderVerified"],
      textualUploadDate: map["textualUploadDate"],
      uploadDate: map["uploadDate"] != null
          ? DateTime.tryParse(
              Utils.retrieveTime(
                map["uploadDate"],
              ),
            )
          : DateTime(1999),
      duration: Duration(seconds: map["duration"]),
      thumbnailUrl: map["thumbnailUrl"],
      uploaderName: map["uploaderName"],
      videoName: map["name"],
      viewCount: map["viewCount"],
    );
  }
}
