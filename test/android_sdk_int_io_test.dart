import 'package:flutter_settings_ui/src/utils/android_sdk_int_io.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses explicit SDK token', () {
    expect(parseAndroidSdkIntFromVersionString('Android 14 (SDK 34)'), 34);
  });

  test('parses explicit API token', () {
    expect(parseAndroidSdkIntFromVersionString('Android API 35'), 35);
  });

  test('falls back to Android major version for modern releases', () {
    expect(parseAndroidSdkIntFromVersionString('Android 15'), 35);
    expect(parseAndroidSdkIntFromVersionString('Android 16'), 36);
    expect(parseAndroidSdkIntFromVersionString('Android 13'), 33);
  });

  test('parses kernel/build token format containing android major', () {
    expect(
      parseAndroidSdkIntFromVersionString(
        'Linux version 6.1.21-android14-11-gabc12345',
      ),
      34,
    );
  });

  test('returns null when no supported SDK signal is present', () {
    expect(parseAndroidSdkIntFromVersionString('Linux kernel 6.6.30'), isNull);
    expect(parseAndroidSdkIntFromVersionString('Darwin 23.4.0'), isNull);
  });
}
