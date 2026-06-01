import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/list/settings_list.dart';
import 'package:flutter_settings_ui/src/sections/custom_settings_section.dart';
import 'package:flutter_settings_ui/src/utils/platform_utils.dart';
import 'package:flutter_settings_ui/src/utils/settings_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('settings list forwards android sdk values', (tester) async {
    late SettingsTheme inheritedTheme;

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsList(
          platform: DevicePlatform.android,
          sections: [
            CustomSettingsSection(
              child: Builder(
                builder: (context) {
                  inheritedTheme = SettingsTheme.of(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );

    expect(inheritedTheme.platform, DevicePlatform.android);
    expect(
      inheritedTheme.androidSdkInt,
      detectAndroidSdkInt(DevicePlatform.android),
    );
    expect(inheritedTheme.iosVersionInt, isNull);
  });

  testWidgets('settings list forwards ios version values', (tester) async {
    late SettingsTheme inheritedTheme;

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsList(
          platform: DevicePlatform.iOS,
          sections: [
            CustomSettingsSection(
              child: Builder(
                builder: (context) {
                  inheritedTheme = SettingsTheme.of(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );

    expect(inheritedTheme.platform, DevicePlatform.iOS);
    expect(
      inheritedTheme.iosVersionInt,
      detectIosMajorVersion(DevicePlatform.iOS),
    );
    expect(inheritedTheme.androidSdkInt, isNull);
  });
}
