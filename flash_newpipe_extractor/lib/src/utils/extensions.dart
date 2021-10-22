import 'enums.dart';

extension ToQualityExt on String {
  Quality get toQuality {
    switch (this) {
      case "HD  -  1080p":
        return Quality.hd1080;
      case "HD  -  720p":
        return Quality.hd720;
      case "Large  -  480p":
        return Quality.large;
      case "Medium  -  360p":
        return Quality.medium;
      case "Small  -  240p":
        return Quality.small;
      case "Tiny  -  144p":
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
        return "HD  -  1080p";
      case Quality.hd720:
        return "HD  -  720p";
      case Quality.large:
        return "Large  -  480p";
      case Quality.medium:
        return "Medium  -  360p";
      case Quality.small:
        return "Small  -  240p";
      case Quality.tiny:
        return "Tiny  -  144p";
      default:
        return "2K";
    }
  }
}

extension FormatToString on String {
  StreamFormat get asStreamFormat {
    switch (this) {
      case "mp4":
        return StreamFormat.mp4;
      case "m4a":
        return StreamFormat.m4a;
      case "3gp":
        return StreamFormat.i3gp;
      case "webm":
        return StreamFormat.webm;
      default:
        return StreamFormat.mp3;
    }
  }
}

extension StringToFormat on StreamFormat {
  String get asString {
    switch (this) {
      case StreamFormat.mp4:
        return "mp4";
      case StreamFormat.m4a:
        return "m4a";
      case StreamFormat.i3gp:
        return "3gp";
      case StreamFormat.webm:
        return "webm";
      default:
        return "mp3";
    }
  }
}
