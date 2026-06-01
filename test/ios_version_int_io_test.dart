import 'package:flutter_settings_ui/src/utils/ios_version_int_io.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses explicit Version token', () {
    expect(parseIosMajorVersionFromString('Version 26.0 (Build 22A123)'), 26);
  });

  test('parses leading generic major number', () {
    expect(parseIosMajorVersionFromString('iOS 18.5 (22F76)'), 18);
  });

  test('returns null when no numeric token is present', () {
    expect(parseIosMajorVersionFromString('Darwin kernel'), isNull);
  });
}
