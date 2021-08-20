import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';

void main() {
  const MethodChannel channel = MethodChannel('flash_newpipe_extractor');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await FlashNewpipeExtractor.platformVersion, '42');
  });
}
