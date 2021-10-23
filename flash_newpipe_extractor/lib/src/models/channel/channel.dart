import 'package:flash_newpipe_extractor/src/models/info_item.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';

class Channel extends InfoItem {
  final String channelName;
  final String? description;
  final bool isVerified;
  final int streamCount;
  final int subscriberCount;
  final String thumbnailUrl;
  final String channelUrl;

  const Channel({
    required this.channelName,
    this.description,
    this.isVerified = false,
    required this.streamCount,
    required this.subscriberCount,
    required this.thumbnailUrl,
    required this.channelUrl,
  }) : super(
          avatarThumbnailUrl: thumbnailUrl,
          name: channelName,
          type: InfoType.CHANNEL,
          url: channelUrl,
        );

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      channelName: map["channelName"],
      isVerified: map["isVerified"] as bool,
      streamCount: map["streamCount"],
      subscriberCount: map["subscriberCount"],
      thumbnailUrl: map["thumbnailUrl"],
      channelUrl: map["channelUrl"],
    );
  }
}
