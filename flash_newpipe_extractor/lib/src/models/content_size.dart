import 'actual_size.dart';

class ContentSize {
  final int bytes;

  const ContentSize({
    required this.bytes,
  });

  double get kiloBytes => bytes / 1024;
  double get megaBytes => kiloBytes / 1024;
  double get gigaBytes => megaBytes / 1024;

  ActualSize get actualSize => ActualSize(bytes: bytes);

  String get sizeToString {
    if (gigaBytes >= 1) {
      return "${gigaBytes.toStringAsFixed(1)} GB";
    } else if (megaBytes >= 1) {
      return "${megaBytes.toStringAsFixed(1)} MB";
    } else
      return "${kiloBytes.toStringAsFixed(1)} KB";
  }
}
