import 'enums.dart';

extension ToQualityExt on String {
  Quality get toQuality {
    switch (this) {
      case "hd1080":
        return Quality.hd1080;
      case "hd720":
        return Quality.hd720;
      case "large":
        return Quality.large;
      case "medium":
        return Quality.medium;
      case "small":
        return Quality.small;
      case "tiny":
        return Quality.tiny;
      default:
        return Quality.hd2k;
    }
  }
}
