class ContentSize {
  final int bytes;

  ContentSize({
    required this.bytes,
  });

  double get kiloBytes => bytes / 1024;
  double get megaBytes => kiloBytes / 1024;
  double get gigaBytes => megaBytes / 1024;

  String get sizeToString {
    if (gigaBytes >= 1) {
      return "${gigaBytes.toStringAsFixed(1)} GB";
    } else if (megaBytes >= 1) {
      return "${megaBytes.toStringAsFixed(1)} MB";
    } else
      return "${kiloBytes.toStringAsFixed(1)} KB";
  }
}
