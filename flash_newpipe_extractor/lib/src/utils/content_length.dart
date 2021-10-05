import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';
import 'package:http/http.dart';

class ContentLength {
  static Future<ContentSize> getStreamSize(Streams stream) async {
    final response = await head(
      Uri.parse(stream.url),
      headers: {
        "user-agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36"
      },
    );
    final totalBytes =
        int.tryParse(response.headers["content-length"] ?? "0") ?? 0;
    final kb = totalBytes / 1024;
    final mb = kb / 1024;
    final gb = mb / 1024;

    return ContentSize(
      bytes: totalBytes,
      kiloBytes: kb,
      megaBytes: mb,
      gigaBytes: gb,
    );
  }
}

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
