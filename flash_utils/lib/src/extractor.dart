import 'method_callls.dart';
import 'models/file_path.dart';

class FlashUtils {
  Future<bool> enterPiPMode(int height, int width) async {
    return FlashUtilsMethodCall.enterPiPMode(height, width);
  }

  Future<FilePath?> selectFolder() async {
    return FlashUtilsMethodCall.selectFolder();
  }
}
