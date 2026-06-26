import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/utils/platform_utils.dart';

class SettingsTheme extends InheritedWidget {
  final SettingsThemeData themeData;
  final DevicePlatform platform;
  final int? androidSdkInt;
  final int? iosVersionInt;

  const SettingsTheme({
    super.key,
    required this.themeData,
    required this.platform,
    this.androidSdkInt,
    this.iosVersionInt,
    required super.child,
  });

  @override
  bool updateShouldNotify(SettingsTheme old) => true;

  static SettingsTheme of(BuildContext context) {
    final SettingsTheme? result = context
        .dependOnInheritedWidgetOfExactType<SettingsTheme>();
    return result!;
  }

  bool get isAndroidSdk36OrAbove {
    return platform == DevicePlatform.android && (androidSdkInt ?? 0) >= 36;
  }

  bool get isIos26OrAbove {
    return platform == DevicePlatform.iOS && (iosVersionInt ?? 0) >= 26;
  }
}

class SettingsThemeData {
  const SettingsThemeData({
    this.trailingTextColor,
    this.settingsListBackground,
    this.settingsSectionBackground,
    this.dividerColor,
    this.tileHighlightColor,
    this.titleTextColor,
    this.leadingIconsColor,
    this.tileDescriptionTextColor,
    this.settingsTileTextColor,
    this.inactiveTitleColor,
    this.inactiveSubtitleColor,
    this.androidTileHorizontalPadding,
    this.androidTileVerticalPadding,
    this.androidLeadingStartPadding,
    this.androidSectionTitleTopPadding,
    this.androidSectionTitleBottomPadding,
    this.androidTitleFontSize,
    this.androidTitleFontWeight,
    this.androidTileBackgroundColor,
    this.androidSectionBorderRadius,
    this.androidGapBetweenTiles,
    this.androidGapBetweenSections,
  });

  final Color? settingsListBackground;
  final Color? trailingTextColor;
  final Color? leadingIconsColor;
  final Color? settingsSectionBackground;
  final Color? dividerColor;
  final Color? tileDescriptionTextColor;
  final Color? tileHighlightColor;
  final Color? titleTextColor;
  final Color? settingsTileTextColor;
  final Color? inactiveTitleColor;
  final Color? inactiveSubtitleColor;
  final double? androidTileHorizontalPadding;
  final double? androidTileVerticalPadding;
  final double? androidLeadingStartPadding;
  final double? androidSectionTitleTopPadding;
  final double? androidSectionTitleBottomPadding;
  final double? androidTitleFontSize;
  final FontWeight? androidTitleFontWeight;
  final Color? androidTileBackgroundColor;
  final double? androidSectionBorderRadius;
  final double? androidGapBetweenTiles;
  final double? androidGapBetweenSections;

  SettingsThemeData merge({SettingsThemeData? theme}) {
    if (theme == null) return this;

    return copyWith(
      leadingIconsColor: theme.leadingIconsColor,
      tileDescriptionTextColor: theme.tileDescriptionTextColor,
      dividerColor: theme.dividerColor,
      trailingTextColor: theme.trailingTextColor,
      settingsListBackground: theme.settingsListBackground,
      settingsSectionBackground: theme.settingsSectionBackground,
      settingsTileTextColor: theme.settingsTileTextColor,
      tileHighlightColor: theme.tileHighlightColor,
      titleTextColor: theme.titleTextColor,
      inactiveTitleColor: theme.inactiveTitleColor,
      inactiveSubtitleColor: theme.inactiveSubtitleColor,
      androidTileHorizontalPadding: theme.androidTileHorizontalPadding,
      androidTileVerticalPadding: theme.androidTileVerticalPadding,
      androidLeadingStartPadding: theme.androidLeadingStartPadding,
      androidSectionTitleTopPadding: theme.androidSectionTitleTopPadding,
      androidSectionTitleBottomPadding: theme.androidSectionTitleBottomPadding,
      androidTitleFontSize: theme.androidTitleFontSize,
      androidTitleFontWeight: theme.androidTitleFontWeight,
      androidTileBackgroundColor: theme.androidTileBackgroundColor,
      androidSectionBorderRadius: theme.androidSectionBorderRadius,
      androidGapBetweenTiles: theme.androidGapBetweenTiles,
      androidGapBetweenSections: theme.androidGapBetweenSections,
    );
  }

  SettingsThemeData copyWith({
    Color? settingsListBackground,
    Color? trailingTextColor,
    Color? leadingIconsColor,
    Color? settingsSectionBackground,
    Color? dividerColor,
    Color? tileDescriptionTextColor,
    Color? tileHighlightColor,
    Color? titleTextColor,
    Color? settingsTileTextColor,
    Color? inactiveTitleColor,
    Color? inactiveSubtitleColor,
    double? androidTileHorizontalPadding,
    double? androidTileVerticalPadding,
    double? androidLeadingStartPadding,
    double? androidSectionTitleTopPadding,
    double? androidSectionTitleBottomPadding,
    double? androidTitleFontSize,
    FontWeight? androidTitleFontWeight,
    Color? androidTileBackgroundColor,
    double? androidSectionBorderRadius,
    double? androidGapBetweenTiles,
    double? androidGapBetweenSections,
  }) {
    return SettingsThemeData(
      settingsListBackground:
          settingsListBackground ?? this.settingsListBackground,
      trailingTextColor: trailingTextColor ?? this.trailingTextColor,
      leadingIconsColor: leadingIconsColor ?? this.leadingIconsColor,
      settingsSectionBackground:
          settingsSectionBackground ?? this.settingsSectionBackground,
      dividerColor: dividerColor ?? this.dividerColor,
      tileDescriptionTextColor:
          tileDescriptionTextColor ?? this.tileDescriptionTextColor,
      tileHighlightColor: tileHighlightColor ?? this.tileHighlightColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      inactiveTitleColor: inactiveTitleColor ?? this.inactiveTitleColor,
      inactiveSubtitleColor:
          inactiveSubtitleColor ?? this.inactiveSubtitleColor,
      settingsTileTextColor:
          settingsTileTextColor ?? this.settingsTileTextColor,
      androidTileHorizontalPadding:
          androidTileHorizontalPadding ?? this.androidTileHorizontalPadding,
      androidTileVerticalPadding:
          androidTileVerticalPadding ?? this.androidTileVerticalPadding,
      androidLeadingStartPadding:
          androidLeadingStartPadding ?? this.androidLeadingStartPadding,
      androidSectionTitleTopPadding:
          androidSectionTitleTopPadding ?? this.androidSectionTitleTopPadding,
      androidSectionTitleBottomPadding:
          androidSectionTitleBottomPadding ??
          this.androidSectionTitleBottomPadding,
      androidTitleFontSize: androidTitleFontSize ?? this.androidTitleFontSize,
      androidTitleFontWeight:
          androidTitleFontWeight ?? this.androidTitleFontWeight,
      androidTileBackgroundColor:
          androidTileBackgroundColor ?? this.androidTileBackgroundColor,
      androidSectionBorderRadius:
          androidSectionBorderRadius ?? this.androidSectionBorderRadius,
      androidGapBetweenTiles:
          androidGapBetweenTiles ?? this.androidGapBetweenTiles,
      androidGapBetweenSections:
          androidGapBetweenSections ?? this.androidGapBetweenSections,
    );
  }
}
