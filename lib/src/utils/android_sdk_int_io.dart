import 'dart:io' as io;

import 'package:device_info_plus/device_info_plus.dart';

int? readAndroidSdkInt() {
  if (!io.Platform.isAndroid) {
    return null;
  }

  return parseAndroidSdkIntFromVersionString(
    io.Platform.operatingSystemVersion,
  );
}

Future<int?> readAndroidSdkIntAsync() async {
  if (!io.Platform.isAndroid) {
    return null;
  }

  try {
    final info = await DeviceInfoPlugin().androidInfo;
    return info.version.sdkInt;
  } catch (_) {
    return readAndroidSdkInt();
  }
}

int? parseAndroidSdkIntFromVersionString(String version) {
  final explicitSdkPatterns = <RegExp>[
    RegExp(r'(?:SDK|API)\s*(?:INT)?\s*[:=]?\s*(\d+)', caseSensitive: false),
    RegExp(r'sdk(?:_int)?\s*[:=]\s*(\d+)', caseSensitive: false),
  ];

  for (final pattern in explicitSdkPatterns) {
    final match = pattern.firstMatch(version);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
  }

  // Some devices expose only Android major info (for example "Android 15"
  // or kernel strings containing "android14").
  final androidMajorMatch = RegExp(
    r'android[^\d]{0,3}(\d+)(?:\.\d+)?',
    caseSensitive: false,
  ).firstMatch(version);

  if (androidMajorMatch != null) {
    final major = int.tryParse(androidMajorMatch.group(1)!);
    if (major != null) {
      return _sdkIntFromModernAndroidMajor(major);
    }
  }

  return null;
}

int? _sdkIntFromModernAndroidMajor(int major) {
  switch (major) {
    case 16:
      return 36;
    case 15:
      return 35;
    case 14:
      return 34;
    case 13:
      return 33;
    case 12:
      return 31;
    case 11:
      return 30;
    case 10:
      return 29;
    case 9:
      return 28;
    case 8:
      return 26;
    case 7:
      return 24;
    case 6:
      return 23;
    case 5:
      return 21;
    default:
      return null;
  }
}
