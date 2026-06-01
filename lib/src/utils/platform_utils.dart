import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_settings_ui/src/utils/android_sdk_int_stub.dart'
    if (dart.library.io) 'package:flutter_settings_ui/src/utils/android_sdk_int_io.dart'
    as android_sdk;
import 'package:flutter_settings_ui/src/utils/ios_version_int_stub.dart'
    if (dart.library.io) 'package:flutter_settings_ui/src/utils/ios_version_int_io.dart'
    as ios_version;

/// Since we cannot extend targetPlatfom, create own enum.
enum DevicePlatform {
  /// Android: <https://www.android.com/>
  android,

  /// Fuchsia: <https://fuchsia.dev/fuchsia-src/concepts>
  fuchsia,

  /// iOS: <https://www.apple.com/ios/>
  iOS,

  /// Linux: <https://www.linux.org>
  linux,

  /// macOS: <https://www.apple.com/macos>
  macOS,

  /// Windows: <https://www.windows.com>
  windows,

  /// Web
  web,

  /// Use this to specify you want to use the default device platform
  device,
}

DevicePlatform detectPlatform(BuildContext context) {
  if (kIsWeb) return DevicePlatform.web;

  final platform = Theme.of(context).platform;

  switch (platform) {
    case TargetPlatform.android:
      return DevicePlatform.android;
    case TargetPlatform.fuchsia:
      return DevicePlatform.fuchsia;
    case TargetPlatform.iOS:
      return DevicePlatform.iOS;
    case TargetPlatform.linux:
      return DevicePlatform.linux;
    case TargetPlatform.macOS:
      return DevicePlatform.macOS;
    case TargetPlatform.windows:
      return DevicePlatform.windows;
  }
}

int? detectAndroidSdkInt(DevicePlatform platform) {
  if (platform != DevicePlatform.android) {
    return null;
  }

  return android_sdk.readAndroidSdkInt();
}

Future<int?> resolveAndroidSdkInt(DevicePlatform platform) async {
  if (platform != DevicePlatform.android) {
    return null;
  }

  final sdkInt = await android_sdk.readAndroidSdkIntAsync();
  return sdkInt ?? detectAndroidSdkInt(platform);
}

int? detectIosMajorVersion(DevicePlatform platform) {
  if (platform != DevicePlatform.iOS) {
    return null;
  }

  return ios_version.readIosMajorVersion();
}

Future<int?> resolveIosMajorVersion(DevicePlatform platform) async {
  if (platform != DevicePlatform.iOS) {
    return null;
  }

  final version = await ios_version.readIosMajorVersionAsync();
  return version ?? detectIosMajorVersion(platform);
}
