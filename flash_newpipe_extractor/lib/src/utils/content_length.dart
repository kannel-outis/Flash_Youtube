import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';
import 'package:http/http.dart';

class ContentLength {
  static Future<String> getStreamSize(Streams stream) async {
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

    if (gb >= 1) {
      return "${gb.roundToDouble()} GB";
    } else if (mb >= 1) {
      return "${mb.roundToDouble()} MB";
    } else
      return "${kb.roundToDouble()} KB";
  }
}
