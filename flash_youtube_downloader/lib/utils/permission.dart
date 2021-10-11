import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> requestPermission(
      {Permission permission = Permission.storage}) async {
    final status = await permission.status;
    if (status != PermissionStatus.granted) {
      final response = await permission.request();
      return response.isGranted;
    } else {
      return true;
    }
  }
}
