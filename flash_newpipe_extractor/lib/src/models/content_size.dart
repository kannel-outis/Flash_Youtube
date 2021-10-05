class ContentSize {
  final int bytes;
  final double kiloBytes;
  final double megaBytes;
  final double gigaBytes;

  const ContentSize({
    required this.bytes,
    required this.kiloBytes,
    required this.megaBytes,
    required this.gigaBytes,
  });

  String get sizeToString {
    if (gigaBytes >= 1) {
      return "${gigaBytes.toStringAsFixed(1)} GB";
    } else if (megaBytes >= 1) {
      return "${megaBytes.toStringAsFixed(1)} MB";
    } else
      return "${kiloBytes.toStringAsFixed(1)} KB";
  }
}
