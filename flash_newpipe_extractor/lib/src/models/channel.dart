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
  final Page? nextpage;

  Channel({
    this.nextpage,
    required this.name,
    this.description,
    required this.id,
    required this.avatarUrl,
    this.bannerUrl,
    this.feedUrl,
    this.subscriberCount,
    required this.url,
  }) {
    if (nextpage != null) {
      this.nextpage!.channel = this;
    }
  }

  String get hdAvatarUrl => avatarUrl.replaceAll("=s48", "=s150");
  final List<YoutubeVideo> _listOfVideo = [];
  List<YoutubeVideo> get videoUploads => _listOfVideo;
  void addToVideoList(YoutubeVideo video) {
    _listOfVideo.add(video);
  }

  Future<void> requestNextpage() async {}

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      name: map["channelName"],
      id: map["channelId"],
      avatarUrl: map["channelAvatarUrl"],
      url: map["channelUrl"],
      bannerUrl: map["channelBannerUrl"],
      description: map["channelDescription"],
      feedUrl: map["channelFeedUrl"],
      subscriberCount: map["channelSubscriberCount"],
      nextpage: Page.fromMap(Map.from(map["nextPageInfo"])),
    );
  }
}
