
import 'dart:async';

import 'package:flutter/services.dart';

class FlashUtils {
  static const MethodChannel _channel = MethodChannel('flash_utils');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
