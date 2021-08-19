
import 'dart:async';

import 'package:flutter/services.dart';

class FlashNewpipeExtractor {
  static const MethodChannel _channel =
      const MethodChannel('flash_newpipe_extractor');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
