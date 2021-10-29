import 'dart:async';

import 'package:flutter/services.dart';

import 'models/file_path.dart';

class FlashUtilsMethodCall {
  static const MethodChannel _channel = MethodChannel('flash_utils');

  static Future<bool> enterPiPMode(int height, int width) async {
    final result = await _channel.invokeMethod(
      "enterPiPMode",
      <String, int>{
        "height": height,
        "width": width,
      },
    );
    return result as bool;
  }

  static Future<FilePath?> selectFolder() async {
    final _completer = Completer<FilePath?>();
    await _channel.invokeMethod("select_folder");
    const EventChannel("flashEventChannel")
        .receiveBroadcastStream()
        .listen((event) {
      final result = Map<String, dynamic>.from(event);
      if (result.containsKey("canceled")) {
        _completer.complete(null);
      } else {
        final filePath =
            FilePath.fromMap(Map<String, dynamic>.from(result["result"]));
        _completer.complete(filePath);
      }
    });

    return await _completer.future;
  }
}
