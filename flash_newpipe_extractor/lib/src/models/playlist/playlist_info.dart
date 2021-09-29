import 'package:flash_newpipe_extractor/src/models/page/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';
import 'package:flash_newpipe_extractor/src/models/video/video.dart';

class PlaylistInfo extends PageManager<YoutubeVideo, PlaylistInfo>
    implements GrowablePage<YoutubeVideo, PlaylistInfo> {
  final String? bannerUrl;
  final bool isUploaderVerified;
  final int streamCount;
  final String? subChannelAvatarUrl;
  final String? subChannelName;
  final String? subChannelUrl;
  final String thumbnailUrl;
  final String uploaderAvatarUrl;
  final String uploaderName;
  final String uploaderUrl;
  final String url;
  final String name;
  final String? originalUrl;

  PlaylistInfo({
    this.bannerUrl,
    this.isUploaderVerified = false,
    this.streamCount = 0,
    this.subChannelAvatarUrl,
    this.subChannelName,
    this.subChannelUrl,
    this.originalUrl,
    required this.name,
    required this.url,
    required this.thumbnailUrl,
    required this.uploaderAvatarUrl,
    required this.uploaderName,
    required this.uploaderUrl,
  }) : super(value: url) {
    super.child = this;
  }

  factory PlaylistInfo.fromMap(Map<String, dynamic> map) {
    return PlaylistInfo(
      thumbnailUrl: map["thumbnailUrl"],
      uploaderAvatarUrl: map["uploaderAvatarUrl"],
      uploaderName: map["uploaderName"],
      uploaderUrl: map["uploaderUrl"],
      bannerUrl: map["bannerUrl"],
      isUploaderVerified: map["isUploaderVerified"],
      streamCount: map["streamCount"],
      subChannelAvatarUrl: map["subChannelAvatarUrl"],
      subChannelName: map["subChannelName"],
      subChannelUrl: map["subChannelUrl"],
      url: map["url"],
      name: map["name"],
      originalUrl: map["originalUrl"],
    );
  }
  final List<YoutubeVideo> _growableListItems = [];

  @override
  void addToGrowableList(YoutubeVideo item) {
    _growableListItems.add(item);
  }

  @override
  List<YoutubeVideo> get growableListItems => _growableListItems;

  @override
  PageManager<YoutubeVideo, PlaylistInfo> get manager => this;

  @override
  String get type => "playlist";
}
