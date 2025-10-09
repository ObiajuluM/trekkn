import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashString(String input) {
  final bytes = utf8.encode(input); // Convert string to bytes
  final digest = sha256.convert(bytes); // Hash using SHA-256
  return digest.toString(); // Return as hex string
}

Future<String?> getDeviceId(String userId) async {
  final deviceInfo = DeviceInfoPlugin();
  if (defaultTargetPlatform == TargetPlatform.android) {
    final androidInfo = await deviceInfo.androidInfo;
    return hashString(androidInfo.id + userId);
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  }
  return null;
}
