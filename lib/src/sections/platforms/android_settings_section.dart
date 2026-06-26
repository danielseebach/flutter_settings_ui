import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:flutter_settings_ui/src/utils/settings_theme.dart';

class AndroidSettingsSection extends StatelessWidget {
  const AndroidSettingsSection({
    required this.tiles,
    required this.margin,
    this.title,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return buildSectionBody(context);
  }

  Widget buildSectionBody(BuildContext context) {
    final theme = SettingsTheme.of(context);
    final isSdk36OrAbove = theme.isAndroidSdk36OrAbove;
    final scaleFactor = MediaQuery.textScalerOf(context).scale(1);
    final titleHorizontalPadding =
        theme.themeData.androidTileHorizontalPadding ?? 24;
    final titleTopPadding = theme.themeData.androidSectionTitleTopPadding ?? 24;
    final titleBottomPadding =
        theme.themeData.androidSectionTitleBottomPadding ?? 10;
    final gapBetweenTiles = isSdk36OrAbove
        ? (theme.themeData.androidGapBetweenTiles ?? 4)
        : 0.0;
    final sectionBorderRadius = theme.themeData.androidSectionBorderRadius ?? 0;

    final tileChildren = <Widget>[];
    for (var index = 0; index < tiles.length; index++) {
      tileChildren.add(tiles[index]);
      if (gapBetweenTiles > 0 && index != tiles.length - 1) {
        tileChildren.add(SizedBox(height: gapBetweenTiles));
      }
    }

    final tileList = Column(children: tileChildren);

    final sectionBody = isSdk36OrAbove
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: titleHorizontalPadding),
            decoration: BoxDecoration(
              color: theme.themeData.settingsSectionBackground,
              borderRadius: BorderRadius.circular(sectionBorderRadius),
            ),
            clipBehavior: Clip.hardEdge,
            child: tileList,
          )
        : Container(
            color: theme.themeData.settingsSectionBackground,
            child: tileList,
          );

    if (title == null) {
      return sectionBody;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: titleTopPadding * scaleFactor,
            bottom: titleBottomPadding * scaleFactor,
            start: titleHorizontalPadding,
            end: titleHorizontalPadding,
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: theme.themeData.titleTextColor),
            child: title!,
          ),
        ),
        sectionBody,
      ],
    );
  }
}
