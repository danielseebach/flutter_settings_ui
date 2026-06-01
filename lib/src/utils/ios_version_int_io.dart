import 'dart:io' as io;

import 'package:device_info_plus/device_info_plus.dart';

int? readIosMajorVersion() {
  if (!io.Platform.isIOS) {
    return null;
  }

  final version = io.Platform.operatingSystemVersion;
  return parseIosMajorVersionFromString(version);
}

Future<int?> readIosMajorVersionAsync() async {
  if (!io.Platform.isIOS) {
    return null;
  }

  try {
    final info = await DeviceInfoPlugin().iosInfo;
    return parseIosMajorVersionFromString(info.systemVersion) ??
        readIosMajorVersion();
  } catch (_) {
    return readIosMajorVersion();
  }
}

int? parseIosMajorVersionFromString(String version) {
  final versionMatch = RegExp(r'Version\s*(\d+)').firstMatch(version);
  if (versionMatch != null) {
    return int.tryParse(versionMatch.group(1)!);
  }

  final genericMatch = RegExp(r'(\d+)').firstMatch(version);
  if (genericMatch != null) {
    return int.tryParse(genericMatch.group(1)!);
  }

  return null;
}
