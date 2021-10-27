import 'dart:async';

import 'package:flutter/services.dart';

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
}
