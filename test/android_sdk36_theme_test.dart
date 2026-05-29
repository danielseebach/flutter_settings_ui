import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/utils/platform_utils.dart';
import 'package:flutter_settings_ui/src/utils/settings_theme.dart';
import 'package:flutter_settings_ui/src/utils/theme_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('android sdk 35 keeps legacy spacing and typography', (
    tester,
  ) async {
    late ThemeData appTheme;
    late SettingsThemeData settingsTheme;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
        ),
        home: Builder(
          builder: (context) {
            appTheme = Theme.of(context);
            settingsTheme = getTheme(
              context: context,
              platform: DevicePlatform.android,
              brightness: Brightness.light,
              androidSdkInt: 35,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(settingsTheme.androidTileVerticalPadding, 19);
    expect(settingsTheme.androidTitleFontSize, 18);
    expect(settingsTheme.androidTitleFontWeight, FontWeight.w400);
    expect(settingsTheme.androidTileBackgroundColor, Colors.transparent);
    expect(settingsTheme.titleTextColor, isNot(appTheme.colorScheme.primary));
  });

  testWidgets('android sdk 36 uses refreshed spacing and color tokens', (
    tester,
  ) async {
    late SettingsThemeData settingsTheme;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
        ),
        home: Builder(
          builder: (context) {
            settingsTheme = getTheme(
              context: context,
              platform: DevicePlatform.android,
              brightness: Brightness.light,
              androidSdkInt: 36,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(settingsTheme.androidTileHorizontalPadding, 18);
    expect(settingsTheme.androidTileVerticalPadding, 18);
    expect(settingsTheme.androidLeadingStartPadding, 18);
    expect(settingsTheme.androidTitleFontSize, 17);
    expect(settingsTheme.androidTitleFontWeight, FontWeight.w500);
    expect(settingsTheme.androidSectionBorderRadius, 28);
    expect(settingsTheme.androidGapBetweenTiles, 4);
    expect(settingsTheme.androidGapBetweenSections, 28);
    expect(settingsTheme.settingsListBackground, const Color(0xFFF0F1F8));
    expect(settingsTheme.androidTileBackgroundColor, const Color(0xFFFAF8FF));
    expect(settingsTheme.settingsTileTextColor, const Color(0xFF2F3038));
    expect(settingsTheme.tileDescriptionTextColor, const Color(0xFF646773));
    expect(
      settingsTheme.androidTileBackgroundColor,
      isNot(Colors.transparent),
    );
    expect(settingsTheme.titleTextColor, const Color(0xFF2F3038));
  });

  testWidgets('android sdk 36 dark mode uses provided dark palette', (
    tester,
  ) async {
    late SettingsThemeData settingsTheme;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            settingsTheme = getTheme(
              context: context,
              platform: DevicePlatform.android,
              brightness: Brightness.dark,
              androidSdkInt: 36,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(settingsTheme.settingsListBackground, const Color(0xFF17191F));
    expect(settingsTheme.androidTileBackgroundColor, const Color(0xFF292C34));
    expect(settingsTheme.settingsTileTextColor, const Color(0xFFE7E7F0));
    expect(settingsTheme.tileDescriptionTextColor, const Color(0xFFB8BAC6));
    expect(settingsTheme.titleTextColor, const Color(0xFFE7E7F0));
  });

  testWidgets('ios 25 keeps legacy settings tokens', (tester) async {
    late SettingsThemeData settingsTheme;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            settingsTheme = getTheme(
              context: context,
              platform: DevicePlatform.iOS,
              brightness: Brightness.light,
              androidSdkInt: 36,
              iosVersionInt: 25,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(settingsTheme.settingsListBackground, const Color(0xFFF2F2F7));
    expect(settingsTheme.settingsSectionBackground, CupertinoColors.white);
    expect(
      settingsTheme.dividerColor,
      const Color.fromARGB(255, 238, 238, 238),
    );
    expect(settingsTheme.androidTileVerticalPadding, isNull);
  });

  testWidgets('ios 26 uses refreshed settings tokens', (tester) async {
    late SettingsThemeData settingsTheme;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            settingsTheme = getTheme(
              context: context,
              platform: DevicePlatform.iOS,
              brightness: Brightness.light,
              iosVersionInt: 26,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(settingsTheme.settingsListBackground, const Color(0xFFF6F6FA));
    expect(settingsTheme.settingsSectionBackground, const Color(0xFFFFFFFF));
    expect(settingsTheme.dividerColor, const Color(0xFFE6E6EB));
    expect(settingsTheme.trailingTextColor, const Color(0xFF848489));
  });
}
