import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<String?> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  if (defaultTargetPlatform == TargetPlatform.android) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  }
  return null;
}
