import 'package:flash_newpipe_extractor/src/models/page.dart';
import 'package:flash_newpipe_extractor/src/models/video.dart';

class Channel {
  final String name;
  final String? description;
  final String id;
  final String avatarUrl;
  final String? bannerUrl;
  final String? feedUrl;
  final int? subscriberCount;
  final String url;
  final bool hasVideosNextPage;
  final Page? nextpage;

  Channel({
    //
    this.hasVideosNextPage = false,
    this.nextpage,
    required this.name,
    this.description,
    required this.id,
    required this.avatarUrl,
    this.bannerUrl,
    this.feedUrl,
    this.subscriberCount,
    required this.url,
  });

  String get hdAvatarUrl => avatarUrl.replaceAll("=s48", "=s150");
  final List<YoutubeVideo> _listOfVideo = [];
  List<YoutubeVideo> get videoUploads => _listOfVideo;
  void addToVideoList(YoutubeVideo video) {
    _listOfVideo.add(video);
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      hasVideosNextPage: map["channelHasNextPage"],
      name: map["channelName"],
      id: map["channelId"],
      avatarUrl: map["channelAvatarUrl"],
      url: map["channelUrl"],
      bannerUrl: map["channelBannerUrl"],
      description: map["channelDescription"],
      feedUrl: map["channelFeedUrl"],
      subscriberCount: map["channelSubscriberCount"],
    );
  }
}
