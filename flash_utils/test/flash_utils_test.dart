import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flash_utils/flash_utils.dart';

void main() {
  const MethodChannel channel = MethodChannel('flash_utils');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await FlashUtils.platformVersion, '42');
  // });
}
