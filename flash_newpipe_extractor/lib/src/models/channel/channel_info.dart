import 'package:flash_newpipe_extractor/src/models/page/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';
import 'package:flash_newpipe_extractor/src/models/video/video.dart';

class ChannelInfo extends PageManager<YoutubeVideo, ChannelInfo>
    implements GrowablePage<YoutubeVideo, ChannelInfo> {
  final String name;
  final String? description;
  final String id;
  final String avatarUrl;
  final String? bannerUrl;
  final String? feedUrl;
  final int? subscriberCount;
  final String url;

  ChannelInfo({
    required this.name,
    this.description,
    required this.id,
    required this.avatarUrl,
    this.bannerUrl,
    this.feedUrl,
    this.subscriberCount,
    required this.url,
  }) : super(value: url) {
    super.child = this;
  }

  String get hdAvatarUrl => avatarUrl.replaceAll("=s48", "=s150");
  final List<YoutubeVideo> _listOfVideo = [];

  @override
  List<YoutubeVideo> get growableListItems => _listOfVideo;

  @override
  void addToGrowableList(YoutubeVideo video) {
    _listOfVideo.add(video);
  }

  factory ChannelInfo.fromMap(Map<String, dynamic> map) {
    return ChannelInfo(
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
  PageManager<YoutubeVideo, ChannelInfo> get manager => this;

  @override
  String get type => "channels";
}
