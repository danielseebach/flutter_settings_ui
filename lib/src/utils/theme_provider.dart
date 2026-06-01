import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/utils/platform_utils.dart';
import 'package:flutter_settings_ui/src/utils/settings_theme.dart';

SettingsThemeData getTheme({
  required BuildContext context,
  required DevicePlatform platform,
  required Brightness brightness,
  int? androidSdkInt,
  int? iosVersionInt,
}) {
  switch (platform) {
    case DevicePlatform.android:
    case DevicePlatform.fuchsia:
    case DevicePlatform.linux:
      return _androidTheme(
        context: context,
        brightness: brightness,
        androidSdkInt: androidSdkInt,
      );
    case DevicePlatform.iOS:
    case DevicePlatform.macOS:
    case DevicePlatform.windows:
      return _iosTheme(
        context: context,
        brightness: brightness,
        iosVersionInt: iosVersionInt,
      );
    case DevicePlatform.web:
      return _webTheme(context: context, brightness: brightness);
    case DevicePlatform.device:
      throw Exception(
        "You can't use the DevicePlatform.device in this context. "
        'Incorrect platform: ThemeProvider.getTheme',
      );
  }
}

SettingsThemeData _androidTheme({
  required BuildContext context,
  required Brightness brightness,
  int? androidSdkInt,
}) {
  const lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
  const darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

  const lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
  const darkSettingsListBackground = Color.fromRGBO(27, 27, 27, 1);

  const lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
  const darkSettingsTitleColor = Color.fromRGBO(211, 227, 253, 1);

  const lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
  const darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

  const lightSettingsTileTextColor = Color.fromARGB(255, 27, 27, 27);
  const darkSettingsTileTextColor = Color.fromARGB(255, 240, 240, 240);

  const lightInactiveTitleColor = Color.fromARGB(255, 146, 144, 148);
  const darkInactiveTitleColor = Color.fromARGB(255, 118, 117, 122);

  const lightInactiveSubtitleColor = Color.fromARGB(255, 197, 196, 201);
  const darkInactiveSubtitleColor = Color.fromARGB(255, 71, 70, 74);

  const lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
  const darkTileDescriptionTextColor = Color.fromARGB(255, 198, 198, 198);

  final isSdk36OrAbove = (androidSdkInt ?? 0) >= 36;
  final isLight = brightness == Brightness.light;
  final colorScheme = Theme.of(context).colorScheme;

  if (isSdk36OrAbove) {
    const sdk36LightBg = Color(0xFFF0F1F8);
    const sdk36LightSurface = Color(0xFFFAF8FF);
    const sdk36LightText = Color(0xFF2F3038);
    const sdk36LightSubText = Color(0xFF646773);

    const sdk36DarkBg = Color(0xFF17191F);
    const sdk36DarkSurface = Color(0xFF292C34);
    const sdk36DarkText = Color(0xFFE7E7F0);
    const sdk36DarkSubText = Color(0xFFB8BAC6);

    final settingsListBackground = isLight ? sdk36LightBg : sdk36DarkBg;
    final tileBackground = isLight ? sdk36LightSurface : sdk36DarkSurface;
    final textColor = isLight ? sdk36LightText : sdk36DarkText;
    final subTextColor = isLight ? sdk36LightSubText : sdk36DarkSubText;

    return SettingsThemeData(
      tileHighlightColor:
          colorScheme.primary.withValues(alpha: isLight ? 0.12 : 0.20),
      settingsListBackground: settingsListBackground,
      settingsSectionBackground: settingsListBackground,
      titleTextColor: textColor,
      settingsTileTextColor: textColor,
      tileDescriptionTextColor: subTextColor,
      leadingIconsColor: subTextColor,
      inactiveTitleColor: subTextColor,
      inactiveSubtitleColor: subTextColor,
      androidTileBackgroundColor: tileBackground,
      androidTileHorizontalPadding: 18,
      androidTileVerticalPadding: 18,
      androidLeadingStartPadding: 18,
      androidSectionTitleTopPadding: 20,
      androidSectionTitleBottomPadding: 8,
      androidTitleFontSize: 17,
      androidTitleFontWeight: FontWeight.w500,
      androidSectionBorderRadius: 28,
      androidGapBetweenTiles: 2,
      androidGapBetweenSections: 28,
    );
  }

  final listBackground =
      isLight ? lightSettingsListBackground : darkSettingsListBackground;

  final titleTextColor =
      isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

  final settingsTileTextColor =
      isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

  final tileHighlightColor =
      isLight ? lightTileHighlightColor : darkTileHighlightColor;

  final tileDescriptionTextColor =
      isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

  final leadingIconsColor =
      isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

  final inactiveTitleColor =
      isLight ? lightInactiveTitleColor : darkInactiveTitleColor;

  final inactiveSubtitleColor =
      isLight ? lightInactiveSubtitleColor : darkInactiveSubtitleColor;

  return SettingsThemeData(
    tileHighlightColor: tileHighlightColor,
    settingsListBackground: listBackground,
    titleTextColor: titleTextColor,
    settingsTileTextColor: settingsTileTextColor,
    tileDescriptionTextColor: tileDescriptionTextColor,
    leadingIconsColor: leadingIconsColor,
    inactiveTitleColor: inactiveTitleColor,
    inactiveSubtitleColor: inactiveSubtitleColor,
    androidTileHorizontalPadding: 24,
    androidTileVerticalPadding: 19,
    androidLeadingStartPadding: 24,
    androidSectionTitleTopPadding: 24,
    androidSectionTitleBottomPadding: 10,
    androidTitleFontSize: 18,
    androidTitleFontWeight: FontWeight.w400,
    androidTileBackgroundColor: Colors.transparent,
  );
}

SettingsThemeData _iosTheme({
  required BuildContext context,
  required Brightness brightness,
  int? iosVersionInt,
}) {
  const legacyLightSettingsListBackground = Color.fromRGBO(242, 242, 247, 1);
  const legacyDarkSettingsListBackground = CupertinoColors.black;

  const legacyLightSettingSectionColor = CupertinoColors.white;
  const legacyDarkSettingSectionColor = Color.fromARGB(255, 28, 28, 30);

  const legacyLightSettingsTitleColor = Color.fromRGBO(109, 109, 114, 1);
  const legacyDarkSettingsTitleColor = CupertinoColors.systemGrey;

  const legacyLightDividerColor = Color.fromARGB(255, 238, 238, 238);
  const legacyDarkDividerColor = Color.fromARGB(255, 40, 40, 42);

  const legacyLightTrailingTextColor = Color.fromARGB(255, 138, 138, 142);
  const legacyDarkTrailingTextColor = Color.fromARGB(255, 152, 152, 159);

  const legacyLightTileHighlightColor = Color.fromARGB(255, 209, 209, 214);
  const legacyDarkTileHighlightColor = Color.fromARGB(255, 58, 58, 60);

  const legacyLightSettingsTileTextColor = CupertinoColors.black;
  const legacyDarkSettingsTileTextColor = CupertinoColors.white;

  const legacyLightLeadingIconsColor = CupertinoColors.inactiveGray;
  const legacyDarkLeadingIconsColor = CupertinoColors.inactiveGray;

  const modernLightSettingsListBackground = Color.fromRGBO(246, 246, 250, 1);
  const modernDarkSettingsListBackground = Color.fromRGBO(0, 0, 0, 1);

  const modernLightSettingSectionColor = Color.fromRGBO(255, 255, 255, 1);
  const modernDarkSettingSectionColor = Color.fromRGBO(30, 30, 34, 1);

  const modernLightSettingsTitleColor = Color.fromRGBO(104, 104, 110, 1);
  const modernDarkSettingsTitleColor = Color.fromRGBO(174, 174, 178, 1);

  const modernLightDividerColor = Color.fromRGBO(230, 230, 235, 1);
  const modernDarkDividerColor = Color.fromRGBO(57, 57, 61, 1);

  const modernLightTrailingTextColor = Color.fromRGBO(132, 132, 137, 1);
  const modernDarkTrailingTextColor = Color.fromRGBO(162, 162, 168, 1);

  const modernLightTileHighlightColor = Color.fromRGBO(224, 224, 229, 1);
  const modernDarkTileHighlightColor = Color.fromRGBO(67, 67, 71, 1);

  const modernLightSettingsTileTextColor = Color.fromRGBO(18, 18, 20, 1);
  const modernDarkSettingsTileTextColor = Color.fromRGBO(246, 246, 247, 1);

  const modernLightLeadingIconsColor = Color.fromRGBO(132, 132, 137, 1);
  const modernDarkLeadingIconsColor = Color.fromRGBO(152, 152, 157, 1);

  final isLight = brightness == Brightness.light;
  final isIos26OrAbove = (iosVersionInt ?? 0) >= 26;

  final listBackground = isLight
      ? (isIos26OrAbove
          ? modernLightSettingsListBackground
          : legacyLightSettingsListBackground)
      : (isIos26OrAbove
          ? modernDarkSettingsListBackground
          : legacyDarkSettingsListBackground);

  final sectionBackground = isLight
      ? (isIos26OrAbove
          ? modernLightSettingSectionColor
          : legacyLightSettingSectionColor)
      : (isIos26OrAbove
          ? modernDarkSettingSectionColor
          : legacyDarkSettingSectionColor);

  final titleTextColor = isLight
      ? (isIos26OrAbove
          ? modernLightSettingsTitleColor
          : legacyLightSettingsTitleColor)
      : (isIos26OrAbove
          ? modernDarkSettingsTitleColor
          : legacyDarkSettingsTitleColor);

  final settingsTileTextColor = isLight
      ? (isIos26OrAbove
          ? modernLightSettingsTileTextColor
          : legacyLightSettingsTileTextColor)
      : (isIos26OrAbove
          ? modernDarkSettingsTileTextColor
          : legacyDarkSettingsTileTextColor);

  final dividerColor = isLight
      ? (isIos26OrAbove ? modernLightDividerColor : legacyLightDividerColor)
      : (isIos26OrAbove ? modernDarkDividerColor : legacyDarkDividerColor);

  final trailingTextColor = isLight
      ? (isIos26OrAbove
          ? modernLightTrailingTextColor
          : legacyLightTrailingTextColor)
      : (isIos26OrAbove
          ? modernDarkTrailingTextColor
          : legacyDarkTrailingTextColor);

  final tileHighlightColor = isLight
      ? (isIos26OrAbove
          ? modernLightTileHighlightColor
          : legacyLightTileHighlightColor)
      : (isIos26OrAbove
          ? modernDarkTileHighlightColor
          : legacyDarkTileHighlightColor);

  final leadingIconsColor = isLight
      ? (isIos26OrAbove
          ? modernLightLeadingIconsColor
          : legacyLightLeadingIconsColor)
      : (isIos26OrAbove
          ? modernDarkLeadingIconsColor
          : legacyDarkLeadingIconsColor);

  return SettingsThemeData(
    tileHighlightColor: tileHighlightColor,
    settingsListBackground: listBackground,
    settingsSectionBackground: sectionBackground,
    titleTextColor: titleTextColor,
    dividerColor: dividerColor,
    trailingTextColor: trailingTextColor,
    settingsTileTextColor: settingsTileTextColor,
    leadingIconsColor: leadingIconsColor,
    inactiveTitleColor: CupertinoColors.inactiveGray,
    inactiveSubtitleColor: CupertinoColors.inactiveGray,
  );
}

SettingsThemeData _webTheme({
  required BuildContext context,
  required Brightness brightness,
}) {
  const lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
  const darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

  const lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
  //done
  const darkSettingsListBackground = Color.fromRGBO(32, 33, 36, 1);

  const lightSettingSectionColor = CupertinoColors.white;
  //done
  const darkSettingSectionColor = Color(0xFF292a2d);

  const lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
  //done
  const darkSettingsTitleColor = Color.fromRGBO(232, 234, 237, 1);

  const lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
  const darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

  const lightSettingsTileTextColor = Color.fromARGB(255, 27, 27, 27);
  //done
  const darkSettingsTileTextColor = Color.fromARGB(232, 234, 237, 240);

  const lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
  const darkTileDescriptionTextColor = Color.fromARGB(154, 160, 166, 198);

  final isLight = brightness == Brightness.light;

  final listBackground =
      isLight ? lightSettingsListBackground : darkSettingsListBackground;

  final titleTextColor =
      isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

  final settingsTileTextColor =
      isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

  final tileHighlightColor =
      isLight ? lightTileHighlightColor : darkTileHighlightColor;

  final tileDescriptionTextColor =
      isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

  final leadingIconsColor =
      isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

  final sectionBackground =
      isLight ? lightSettingSectionColor : darkSettingSectionColor;

  return SettingsThemeData(
    tileHighlightColor: tileHighlightColor,
    settingsListBackground: listBackground,
    titleTextColor: titleTextColor,
    settingsSectionBackground: sectionBackground,
    settingsTileTextColor: settingsTileTextColor,
    tileDescriptionTextColor: tileDescriptionTextColor,
    leadingIconsColor: leadingIconsColor,
  );
}
