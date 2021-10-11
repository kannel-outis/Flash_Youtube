import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> requestPermission(
      {Permission? permission = Permission.storage}) async {
    if (await permission!.status.isGranted) {
      return permission.request().then((value) {
        if (value.isDenied || value.isPermanentlyDenied) {
          return false;
        } else {
          return true;
        }
      });
    }

    return false;
  }
}
