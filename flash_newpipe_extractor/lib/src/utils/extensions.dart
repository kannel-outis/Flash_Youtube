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

extension QualityToString on Quality {
  String get qualityToString {
    switch (this) {
      case Quality.hd1080:
        return "1080p";
      case Quality.hd720:
        return "720p";
      case Quality.large:
        return "480p";
      case Quality.medium:
        return "360p";
      case Quality.small:
        return "240p";
      case Quality.tiny:
        return "144p";
      default:
        return "2K";
    }
  }
}
