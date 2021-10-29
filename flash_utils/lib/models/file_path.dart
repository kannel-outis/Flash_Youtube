import 'package:flash_utils/utils/utils.dart';

class FilePath {
  final String path;
  final String encodedpath;
  final bool isAbsolute;
  final bool isRelative;

  FilePath({
    required this.path,
    required this.encodedpath,
    required this.isAbsolute,
    required this.isRelative,
  });

  factory FilePath.fromMap(Map<String, dynamic> map) {
    return FilePath(
      path: Utils.changeToRealPath(map["path"] as String),
      encodedpath: map["encodedPath"],
      isAbsolute: map["isAbsolute"],
      isRelative: map["isRelative"],
    );
  }
}
