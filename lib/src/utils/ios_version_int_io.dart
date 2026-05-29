import 'dart:io' as io;

int? readIosMajorVersion() {
  if (!io.Platform.isIOS) {
    return null;
  }

  final version = io.Platform.operatingSystemVersion;

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
