import 'package:flash_newpipe_extractor/src/models/info_item.dart';
import 'package:flash_newpipe_extractor/src/utils/enums.dart';

class Playlist extends InfoItem {
  final String uploaderName;
  final int streamCount;
  final String playListName;
  final String thumbnailUrl;
  final String playListUrl;

  const Playlist({
    required this.uploaderName,
    required this.streamCount,
    required this.playListName,
    required this.thumbnailUrl,
    required this.playListUrl,
  }) : super(
          avatarThumbnailUrl: thumbnailUrl,
          name: uploaderName,
          url: playListUrl,
          type: InfoType.PLAYLIST,
        );

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      uploaderName: map["uploaderName"],
      streamCount: int.tryParse(map["streamCount"]) ?? 0,
      playListName: map["playListName"],
      thumbnailUrl: map["thumbnailUrl"],
      playListUrl: map["playListUrl"],
    );
  }
}
