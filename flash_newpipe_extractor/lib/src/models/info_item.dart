import 'package:flash_newpipe_extractor/src/utils/enums.dart';

abstract class InfoItem {
  final InfoType type;
  final String url;
  final String avatarThumbnailUrl;
  final String name;

  const InfoItem({
    required this.type,
    required this.url,
    required this.avatarThumbnailUrl,
    required this.name,
  });
}
