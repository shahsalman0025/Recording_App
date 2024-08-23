import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
}
