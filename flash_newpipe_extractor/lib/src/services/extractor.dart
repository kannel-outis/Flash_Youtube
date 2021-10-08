import 'dart:async';
import 'dart:developer';

import 'package:flash_newpipe_extractor/src/models/content_size.dart';
import 'package:flash_newpipe_extractor/src/models/stream/streams.dart';
import 'package:http/http.dart' as http;

class Extractor {
  const Extractor._();
  static const Map<String, String> defaultHeaders = {
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Firefox/68.0'
  };
  static Future<ContentSize> getStreamSize(Streams stream) async {
    final response = await http.head(
      Uri.parse(stream.url),
      headers: defaultHeaders,
    );
    final totalBytes =
        int.tryParse(response.headers["content-length"] ?? "0") ?? 0;

    return ContentSize(
      bytes: totalBytes,
    );
  }

  static Stream<List<int>> getStream(Streams stream,
      {Map<String, String>? headers,
      bool validate = true,
      int start = 0,
      int errorCount = 0}) async* {
    String? url = stream.url;
    var bytesCount = start;
    var client = http.Client();
    final streamSize = stream.contentSize == null
        ? await stream.streamSize
        : stream.contentSize!;
    for (var i = start; i < streamSize.bytes; i += 9898989) {
      try {
        final request = http.Request('get', Uri.parse(url));
        request.headers['range'] = 'bytes=$i-${i + 9898989 - 1}';
        defaultHeaders.forEach((key, value) {
          if (request.headers[key] == null) {
            request.headers[key] = defaultHeaders[key]!;
          }
        });
        final response = await client.send(request);
        // if (validate) {
        //   _validateResponse(response, response.statusCode);
        // }
        final stream = StreamController<List<int>>();
        response.stream.listen((data) {
          bytesCount += data.length;
          stream.add(data);
        }, onError: (_) => null, onDone: stream.close, cancelOnError: false);
        errorCount = 0;
        yield* stream.stream;
      } on Exception {
        if (errorCount == 5) {
          rethrow;
        }
        await Future.delayed(const Duration(milliseconds: 500));
        yield* getStream(stream,
            headers: headers,
            validate: validate,
            start: bytesCount,
            errorCount: errorCount + 1);
        break;
      }
    }
    client.close();
  }
}
