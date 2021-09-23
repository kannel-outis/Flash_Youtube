import 'package:flash_newpipe_extractor/src/models/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';
import 'package:flash_newpipe_extractor/src/models/video/video.dart';

class Channel extends PageManager<YoutubeVideo, Channel>
    implements GrowablePage<YoutubeVideo, Channel> {
  final String name;
  final String? description;
  final String id;
  final String avatarUrl;
  final String? bannerUrl;
  final String? feedUrl;
  final int? subscriberCount;
  final String url;

  Channel({
    required this.name,
    this.description,
    required this.id,
    required this.avatarUrl,
    this.bannerUrl,
    this.feedUrl,
    this.subscriberCount,
    required this.url,
  }) {
    super.child = this;
  }

  String get hdAvatarUrl => avatarUrl.replaceAll("=s48", "=s150");
  final List<YoutubeVideo> _listOfVideo = [];
  List<YoutubeVideo> get videoUploads => _listOfVideo;

  @override
  void addToGrowableList(YoutubeVideo video) {
    _listOfVideo.add(video);
  }

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
    );
  }

  @override
  Page? get childPage => super.page;

  @override
  Channel? get child => this;
}
